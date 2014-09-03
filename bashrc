function ssh_agent_load()
{
	if [[ -f ~/.ssh/agent ]]; then
		source ~/.ssh/agent || :
	fi
	ssh-add -l >/dev/null 2>&1
	if [[ $? -eq 2 ]]; then
		[[ -S ~/.ssh/sock ]] && /bin/rm ~/.ssh/sock
		# status 2 == couldn't connect to agent
		ssh-agent -a ~/.ssh/sock >| ~/.ssh/agent
		source ~/.ssh/agent
	fi
}

if [[ "$-" == *i* ]]; then
	ssh_agent_load
fi
