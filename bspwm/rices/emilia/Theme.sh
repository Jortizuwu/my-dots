#!/usr/bin/env bash
#  ╔═╗╔╦╗╦╦  ╦╔═╗  ╦═╗╦╔═╗╔═╗
#  ║╣ ║║║║║  ║╠═╣  ╠╦╝║║  ║╣ 	https://github.com/gh0stzk/dotfiles
#  ╚═╝╩ ╩╩╩═╝╩╩ ╩  ╩╚═╩╚═╝╚═╝
## This file will configure the options
## and launch the bars corresponding to each theme.

# Set bspwm configuration for Emilia
set_bspwm_config() {
		# General bspwm config options
		bspc config border_width						5
		bspc config window_gap							10
		#bspc config -m eDP border_radius				 2
		bspc config focus_follows_pointer       		true
		bspc config gapless_monocle             		true
		bspc config pointer_follows_focus       		true
		bspc config -m 1 single_monocle              	true
		bspc config -m 1 top_monocle_padding        	20
		bspc config -m 1 left_monocle_padding       	20 
		bspc config -m 1 right_monocle_padding      	20 
		bspc config -m 1 bottom_monocle_padding     	20 
		# bspc config ignore_ewmh_fullscreen      		enter
		bspc config ignore_ewmh_struts          		true
		bspc config -m 1 top_padding          		30

		# Window rules
		bspc rule --add Blueman-manager             state=floating rectangle=610x610+650+235
		bspc rule --add Brave-browser               rectangle=1130x800+395+140
		bspc rule --add Polkit-gnome-authentication-agent-1 rectangle=810x280+555+399
		bspc rule --add Polybar                     layer=below manage=off
		bspc rule --add Rofi						manage=off
		bspc rule --add Pavucontrol					state=floating rectangle=610x610+650+235
		bspc rule --add Thunar						rectangle=650x500+635+290
		bspc rule --add flameshot                   state=floating border=off
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"
		
		cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				# Colors (Tokyo Night) Emilia Rice
				colors:
				  primary:
				    background: '#1a1b26'
				    foreground: '#c0caf5'

				  normal:
				    black:   '#414868'
				    red:     '#f7768e'
				    green:   '#9ece6a'
				    yellow:  '#e0af68'
				    blue:    '#7aa2f7'
				    magenta: '#bb9af7'
				    cyan:    '#7dcfff'
				    white:   '#787c99'

				  bright:
				    black:   '#414868'
				    red:     '#f7768e'
				    green:   '#9ece6a'
				    yellow:  '#e0af68'
				    blue:    '#7aa2f7'
				    magenta: '#bb9af7'
				    cyan:    '#7dcfff'
				    white:   '#c0caf5'

				  cursor:
				    cursor: '#bb9af7'
				    text:	'#1a1b26'
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#1a1b26\"/g" \
		-e "s/separator_color = .*/separator_color = \"#c0caf5\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#f9f9f9'/g"
		
		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#1a1b26"
				foreground = "#c0caf5"

				[urgency_normal]
				timeout = 6
				background = "#1a1b26"
				foreground = "#c0caf5"

				[urgency_critical]
				timeout = 0
				background = "#1a1b26"
				foreground = "#c0caf5"
_EOF_
}

# Launch the bar
launch_bars() {
		polybar -q emi-bar -c ${rice_dir}/config.ini &
}


### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
launch_bars
