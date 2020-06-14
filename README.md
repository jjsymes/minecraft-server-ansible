# Introduction 
This is an Ansible project that enables provissioning of a minecraft server. The following flavours of Minecraft servers can be installed:

* Vanilla Java
* Bedrock

# Getting Started

* On windows
1.	Have ChefDK installed on a Windows computer with HyperV enabled to test playbook using kitchen.
2.	Be able to run Makefiles on your PC.
3.  Test on windows using 'Makefile.win' Makefile e.g. `make -f Makefile.win kitchen_converge`

* On linux
1.	Have ChefDK and virtualbox installed to test playbook using kitchen.
2.  Test using 'Makefile' Makefile e.g. `make kitchen_converge`

# Build and Test

* run `make -f .\Makefile.win ansible_converge` to build the test kitchen box.
* run `make -f .\Makefile.win ansible_test` to run test lifecycle.
* to run tests on linux run `make ansible_test`

# Resources

* https://hub.docker.com/r/itzg/minecraft-server
* https://minecraft.gamepedia.com/Server/Requirements/Dedicated for server spec requirments
* http://www.aaronbell.com/how-to-run-a-minecraft-server-on-amazon-ec2/ other idea
* https://www.bennetrichter.de/en/tutorials/minecraft-server-linux/ ideas for playbook
* https://minecraft.gamepedia.com/Bedrock_Dedicated_Server bedrock
* https://github.com/TapeWerm/MCscripts/tree/master/systemd admin scripts

# Info

* Need ports open: Custom TCP Port 25565
* Bedrock listens on UDP port 19132 by default
* Whitelist.json structure
      whitelist.json
      [
        {
          "uuid": "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx",
          "name": "Gamertag"
        },
        {
          "uuid": "uuid-goes-here",
          "name": "user1"
        },  {
          "uuid": "uuid-goes-here",
          "name": "player1"
        }
      ]


# Contribute
TODO:

* back up scripts https://skarlso.github.io/2016/04/16/minecraft-server-aws-s3-backup/
* back up integration with aws/Azure/both optional?

# Last error

* last error:

# More Info

* BEDROCK backups:
Backups
> The server supports taking backups of the world files while the server is running. It's not particularly friendly for taking manual backups, but works better when automated. The backup (from the servers perspective) consists of three commands.
> 
> Command	Descriptions
> - save hold - This will ask the server to prepare for a backup. It’s asynchronous and will return immediately.
> - save query - After calling save hold you should call this command repeatedly to see if the preparation has finished. When it returns a success it will return a file list (with lengths for each file) of the files you need to copy. The server will not pause while this is happening, so some files can be modified while the backup is taking place. As long as you only copy the files in the given file list and truncate the copied files to the specified lengths, then the backup should be valid.
> - save resume - When you’re finished with copying the files you should call this to tell the server that it’s okay to remove old files again.