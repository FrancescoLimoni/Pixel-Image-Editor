class MenuBar
    def initialize(app,x,y,z)
        puts "creating menu bar"

        @splashScreenFriendObject = nil
        @canvasSaveMethod = nil

        # set up menu LayerPanel properties ======================================

        menuBar = FXMenuBar.new(x, y | z)  
        menuBar.backColor = "Gray69"
            # create pointers (to link new 'FXMenuPane' wutg a new 'FXMenuTitle')
        fileMenu = FXMenuPane.new(x)  #self refers to the TextEditor window
        about = FXMenuPane.new(x)  #self refers to the TextEditor window

        #load icons functions ==================================================
        def readIcon(scope,path)
            icon = nil
            File.open(File.expand_path(File.dirname(__FILE__)).tap {|pwd| $LOAD_PATH.unshift(pwd) unless $LOAD_PATH.include?(pwd)}+"/"+path, "rb") do |io|
            icon = FXPNGIcon.new(scope, io.read)
            icon.scale(25,25)
            end
            icon
        end

        #create main menu Items ================================================
        
        fileTab = FXMenuTitle.new(menuBar, nil, readIcon(app,"icons/pie.png"), :popupMenu => fileMenu)  
        fileTab.backColor = "Gray69"

        #btns
        fileNew = FXButton.new(menuBar,"\tCreate New Canvas",:icon => readIcon(app,"icons/filenew.png"))
        fileSave = FXButton.new(menuBar,"\tQuick Save",:icon => readIcon(app,"icons/filesave.png"))
        fileSave_s = FXButton.new(menuBar,"\tSave new canvas",:icon => readIcon(app,"icons/filesaves.png"))
        fileLoad = FXButton.new(menuBar,"\tLoad Canvas",:icon => readIcon(app,"icons/fileopen.png"))
        aboutTab = FXButton.new(menuBar,"About")
        
        #create sub menue Items=================================================

            #under 'File' tab 
        newCmd = FXMenuCommand.new(fileMenu, "New")
        loadCmd = FXMenuCommand.new(fileMenu, "Load")
        saveCmd = FXMenuCommand.new(fileMenu, "Save") 
        gitHubLink = FXMenuCommand.new(fileMenu, "GitHub")
        exitCmd = FXMenuCommand.new(fileMenu, "Exit")

            #under 'About' tab
        aboutCmd = FXMenuCommand.new(about, "contact us") 
        
        #splash screen friend function=================================================
        def splashScreenFriendfunction(splahsScreenObject)
            @splashScreenFriendObject = splahsScreenObject
        end
        #canvas friend function=================================================
        def canvasSaveFriendfunction(canvasObject)
            @canvasSaveMethod = canvasObject
        end
        #connect sub menue Items to functions =====================================
        fileNew.connect(SEL_COMMAND) do
            # 'forFriendfunctions' is defined in the splashScreen class
            #@splashScreenFriendObject.forFriendfunctions
            @splashScreenFriendObject.toggleShowSplashScreen

            puts('creating new canvas')
            @canvasSaveMethod.newCanvas
        end
        #**************************************************************************
        newCmd.connect(SEL_COMMAND) do
            # 'forFriendfunctions' is defined in the splashScreen class
            #@splashScreenFriendObject.forFriendfunctions
            @splashScreenFriendObject.toggleShowSplashScreen

            puts('creating new canvas')
            @canvasSaveMethod.newCanvas
        end
        #**************************************************************************
        loadCmd.connect(SEL_COMMAND) do  
            @canvasSaveMethod.load
        end
        #**************************************************************************
        fileLoad.connect(SEL_COMMAND) do  
            @canvasSaveMethod.load 
        end  
        #**************************************************************************
        saveCmd.connect(SEL_COMMAND) do
            #save method defined in canvas
            @canvasSaveMethod.save
            puts ('long save')
        end
        #**************************************************************************
        fileSave_s.connect(SEL_COMMAND) do
            #save method defined in canvas
            @canvasSaveMethod.save
            puts ('long save')
        end
        #**************************************************************************
        fileSave.connect(SEL_COMMAND) do
            @canvasSaveMethod.quickSave
        end
        #**************************************************************************
        exitCmd.connect(SEL_COMMAND) do
            puts "exiting program"
            exit
        end
        #**************************************************************************
        aboutTab.connect(SEL_COMMAND) do
            #Launchy.open("https://github.com/FrancescoLimoni/P.I.E")
            puts 'opened browser'
            Launchy.open(File.expand_path("../..", Dir.pwd)+"/PIEDOC.html")
        end
        #**************************************************************************
        gitHubLink.connect(SEL_COMMAND) do
            Launchy.open("https://github.com/FrancescoLimoni/P.I.E")
            puts 'opening gitHub in browser'
        end
    
    end 

end
