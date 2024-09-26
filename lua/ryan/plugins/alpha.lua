return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local dh = {
			" D.H., 1991           __gggrgM**M#mggg__",
			'                 __wgNN@"B*P""mp""@d#"@N#Nw__',
			"               _g#@0F_a*F#  _*F9m_ ,F9*__9NG#g_",
			'            _mN#F  aM"    #p"    !q@    9NL "9#Qu_',
			'           g#MF _pP"L  _g@"9L_  _g""#__  g"9w_ 0N#p',
			'         _0F jL*"   7_wF     #_gF     9gjF   "bJ  9h_',
			"        j#  gAF    _@NL     _g@#_      J@u_    2#_  #_",
			'       ,FF_#" 9_ _#"  "b_  g@   "hg  _#"  !q_ jF "*_09_',
			'       F N"    #p"      Ng@       `#g"      "w@    "# t',
			'      j p#    g"9_     g@"9_      gP"#_     gF"q    Pb L',
			'      0J  k _@   9g_ j#"   "b_  j#"   "b_ _d"   q_ g  ##',
			'      #F  `NF     "#g"       "Md"       5N#      9W"  j#',
			'      #k  jFb_    g@"q_     _*"9m_     _*"R_    _#Np  J#',
			'      tApjF  9g  J"   9M_ _m"    9%_ _*"   "#  gF  9_jNF',
			'       k`N    "q#       9g@        #gF       ##"    #"j',
			'       `_0q_   #"q_    _&"9p_    _g"`L_    _*"#   jAF,\'',
			'        9# "b_j   "b_ g"    *g _gF    9_ g#"  "L_*"qNF',
			'         "b_ "#_    "NL      _B#      _I@     j#" _#"',
			'           NM_0"*g_ j""9u_  gP  q_  _w@ ]_ _g*"F_g@',
			'            "NNh_ !w#_   9#g"    "m*"   _#*" _dN@"',
			'               9##g_0@q__ #"4_  j*"k __*NF_g#@P"',
			'                 "9NN#gIPNL_ "b@" _2M"Lg#N@F"',
			'                     ""P@*NN#gEZgNN@#@P""',
		}
		local uchiha = {
			"",
			"",
			"",
			"  ⠀⠀⠀ ⠀⠀⠀⣀⣀⣤⣴⣶⣶⣶⣶⣦⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀ ⠀",
			"⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⠏⠁⠀⢶⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀",
			"⠀⢀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠿⣿⡇⠀⠀⠀⣿⠿⢿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀",
			"⠀⢠⣾⣿⣿⣿⣿⣿⡿⠋⣠⣴⣿⣷⣤⣤⣾⣿⣦⣄⠙⢿⣿⣿⣿⣿⣿⣷⡄⠀",
			"⠀⣼⣿⣿⣿⣿⣿⡏⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⢹⣿⣿⣿⣿⣿⣧⠀",
			"⢰⣿⣿⣿⣿⣿⡿⠀⣾⣿⣿⣿⣿⠟⠉⠉⠻⣿⣿⣿⣿⣷⠀⢿⣿⣿⣿⣿⣿⡆",
			"⢸⣿⣿⣿⣿⣿⣇⣰⣿⣿⣿⣿⡇⠀⠀⠀⠀⢸⣿⣿⣿⣿⣆⣸⣿⣿⣿⣿⣿⡇",
			"⠸⣿⣿⣿⡿⣿⠟⠋⠙⠻⣿⣿⣿⣦⣀⣀⣴⣿⣿⣿⣿⠛⠙⠻⣿⣿⣿⣿⣿⠇",
			"⠀⢻⣿⣿⣧⠉⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠈⣿⣿⣿⡟⠀",
			"⠀⠘⢿⣿⣿⣷⣦⣤⣴⣾⠛⠻⢿⣿⣿⣿⣿⡿⠟⠋⣿⣦⣤⠀⣰⣿⣿⡿⠃⠀",
			"⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⣈⣁⣠⣤⣶⣾⣿⣿⣷⣾⣿⣿⡿⠁⠀⠀",
			"⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠻⠿⠿⠿⠿⠟⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		}
		-- Set header
		dashboard.section.header.val = dh
		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fw", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- -- Disable folding on alpha buffer
		-- vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
