# PowerShell Configuration

My powershell configuration

- **Preview**

  At the end of this guide your terminal will be like this.
  ![preview](./images/preview.jpg)

- **Install/Update Powershell**

  First of all, I recommend you install the last version of powershell. You can download it from here. Remember that this version is going to replace the powershell 6 if you have installed it. (Does not affect powershell version 5)
  [https://github.com/PowerShell/PowerShell/releases](Download Powershell)

- **Install Windows Terminal (Optional)**

  If you want to personalize your terminal even more you can install Windows Terminal. You can download it from the microsoft store.
  [https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab](Windows Terminal)

- **Install OhMyZsh for windows (OhMyPosh)**

  You need to use the PowerShell Gallery to install oh-my-posh. (Refered: https://github.com/JanDeDobbeleer/oh-my-posh)

  Install posh-git and oh-my-posh:

  ```
  Install-Module posh-git -Scope CurrentUser
  Install-Module oh-my-posh -Scope CurrentUser
  ```

  Enable the prompt:

  ```
  # Start the default settings
  Set-Prompt
  # Alternatively set the desired theme:
  Set-Theme Agnoster
  ```

  In case you're running this on PS Core, make sure to also install version 2.0.0-beta1 of PSReadLine

  ```
  Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
  ```

  To enable the engine edit your PowerShell profile:

  ```
  if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
  notepad $PROFILE
  ```

  In the file opened copy these lines so next times you open terminal it will load the modules and theme

  ```
  Import-Module posh-git
  Import-Module oh-my-posh
  Set-Theme Paradox
  ```

  Some Useful Commands:

  To see what are your actual settings:

  `$ThemeSettings`

  If you want to open the file that define your profile in powershell.

  `$profile`

  It gives you the path of your configuration profile path. You can open it with the command notepad or code if you have visual studio code.

  `notepad $profile`

  To see what are the names of the available themes:

  `get-theme`

  If you want to test some themes temporaly you can use the command:

  `Set-Theme NameofTheTheme`

  To see what are the actual colors of your theme:

  `Show-ThemeColors`

  To see what are the colors available that you can use:

  `Show-Colors`

  Remember that when you choose a theme and want to see it every time you start powersheel you have to define it in your profile file using

  `notepad $profile`
  Set-Theme NameOfTheme

- **Install Fonts**

  If you dont install the fonts you probably will see something like this:

  ![nofonts](./images/nofonts.jpg)

  So, you should install a font that includes glyphs. Two of them are Cascadia Code PL or MeslolGS NF

  [MesloLGS NF Regular](https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)
  You can install it with double click

  [Cascadia Code](https://github.com/microsoft/cascadia-code/releases)

- **Sudo Command** (Optional)

  Also if you want to have the sudo command like in linux you should download an executable and save it in a folder in your pc and then add that folder in your environment variables path. (You can save that file in c:/Windows folder too. Taking advantage that it is in the environmental variable path) Well, this is optional, you always can change properties of powershell to force it open as administrador always. But, this would be necessary for you if you want to execute something as administrator in ps6 when you are coding in vscode. (You can solve that just open it as administrator too. haha.)

  [Sudo command](./sudo.rar)

- **Installing module for icons**

- **Some color personalization for Readline**

- **If you want you can use my theme**
