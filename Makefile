CCRED=\033[0;31m
CCEND=\033[0m

.PHONY: build backup restore clean chezmoi help

help: ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

onboard: ## Onboard new PVE hosts
	ansible-playbook proxmoxOnboard.yml --user=root -k
	#ansible pvenodes -i inventory -m ping --user=root -k

setup: ## Setup new PVE hosts
	ansible-playbook proxmoxSetup.yml --user=root -k

lxc: ## Setup new LXC on PVE hosts
	ansible-playbook proxmoxLXC.yml --user=root -k

inventory: ## Check current inventory
	ansible-inventory -i inventory.ini --list

onboard-test: ## Confirm that we can get SSH to PVE hosts with root account
	ansible pvenodes -i inventory -m ping --user=root -k


debug: ## Build a local mac setup with debug information
	yamllint proxmoxSetup.yml
	@echo "**********************************************"
	ansible-lint proxmoxSetup.yml -v
	@echo "*********************************************
	ansible-playbook -vv proxmoxSetup.yml --step --extra-vars "dDebug: true"

lint: ## Lint ansible configuration
	yamllint proxmoxSetup.yml
	yamllint proxmoxOnboard.yml
	@echo "**********************************************"
	ansible-lint  proxmoxSetup.yml
	ansible-lint  proxmoxOnboard.yml

clean:
	rm -rf /tmp ## Delete temporary files

ssh: ## Adding key to the ssh-agent
	eval "$(ssh-agent -s)"
	ssh-add -K ~/.ssh/githubCom

stats: ## Current setup statistics
	@clear
	@echo "**********************************************"
	@echo "user-friendly name for the system";scutil --get ComputerName
	@echo ""
	@echo "local (Bonjour) host name";scutil --get LocalHostName
	@echo ""
#	@echo "name associated with hostname(1) and gethostname(3)";scutil --get HostName;@echo ""
	@scutil --dns
	@echo "**********************************************"
	@ansible-galaxy role list
	@echo ""
	@ansible-galaxy collection list
	@echo "**********************************************"

install: ## Initial setup
	brew install sshpass
	brew install yamllint
	ansible-galaxy collection install cielito.proxmox
	@echo "**********************************************"
	@echo "Installation complete"
	@echo "**********************************************"
	@brew list
	@echo "**********************************************"

ssh-test: ## Test if we access the PVE servers using the root account
	ansible pvenodes -i inventory -m ping --user=root -k

galaxy: ## Update galaxy roles and collections
	@ansible-galaxy install -r ./WiP/requirements.yml
