source $DFOX_PATH/aliases/init.sh

# Set fox emoji prompt with success/failure indicator
setopt PROMPT_SUBST
export PS1='🦊 <(%(?,%F{green}✓%f,%F{red}✗%f)) %~ '