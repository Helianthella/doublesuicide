default: install

install:
	-mkdir -p ~/.config/fish/functions
	-cp src/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish

uninstall:
	-rm ~/.config/fish/functions/fish_prompt.fish
