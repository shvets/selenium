# Selenium -- Gem wrapper for selenium server

# Installing Selenium

    $ gem install selenium

# Usage

    selenium install - installs selenium
    selenium         - runs the selenium server 
    
# Note

If you are on OSX, you have better option with homebrew help:

    brew install selenium-server-standalone

Standalone selenium server is implemented as launchd agent.

To have launchd start selenium-server-standalone at login, create soft link:

    ln -sfv /usr/local/opt/selenium-server-standalone/*.plist ~/Library/LaunchAgents

Then load selenium-server-standalone agent:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.selenium-server-standalone.plist

It will run selenium server on port 4444.

If you don't want to use agent, use java directly:

    java -jar /usr/local/opt/selenium-server-standalone/selenium-server-standalone-2.35.0.jar -p 4444

