const botconfig = require("./botconfig.json");
const Discord = require("discord.js");
const bot = new Discord.Client({disableEveryone: true });

bot.on("ready", async () => {
	console.log(`${bot.user.username} is online!`);
});

bot.on("message", async message => {
	if(message.author.bot) return;
	if(message.channel.type === "dm") return;
	
	let prefix = botconfig.prefix;
	let messageArray = message.content.split(" ");
	let cmd = messageArray[0];
	let args = messageArray.slice(1);
	
	if(cmd === `${prefix}hello`){
		return message.channel.send("Hello");
	}
	
	if(cmd === `${prefix}cu` || cmd === `${prefix}who`){
        message.delete(500) // ?
		var username = args[0];
		bot.fetchUser(username).then(myUser => {
			console.log(myUser.tag); // My user's avatar is here!
			return message.channel.send(`<@${myUser.id}>`);
		});
		
	}
	if(cmd === `${prefix}key`){
        message.delete(500) // ?
		var discord = `${message.author.id}`;
		var username = `${message.author.tag}`;
		if (! /^[a-zA-Z0-9#-]+$/.test(username)) {
			if(args == "" || args === null){
				return message.author.send("Your name contains symbols, please use !key [name]");
			}else{
				if(! /^[a-zA-Z0-9#-]+$/.test(args)){
					return message.author.send("Your name contains symbols, please use !key [name]");
				}else{
					var username = args[0];
					var request = require('request');
					request.post({url:'https://tholr.online/inc/createuser.php', form: {name:username,d_name:discord}}, function (error, response, body) {
					  console.log('error:', error); // Print the error if one occurred
					  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
					  console.log('body:', body); // Print the HTML for the Google homepage.
					  return message.author.send(body);
					});
				}
			}
		}else{
			var request = require('request');
			request.post({url:'https://tholr.online/inc/createuser.php', form: {name:username,d_name:discord}}, function (error, response, body) {
			  console.log('error:', error); // Print the error if one occurred
			  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
			  console.log('body:', body); // Print the HTML for the Google homepage.
			  return message.author.send(body);
			});
		}

	}
	if(cmd === `${prefix}mykey`){
        message.delete(500) // ?
		var username = `${message.author.id}`;
			var request = require('request');
			request.post({url:'https://tholr.online/inc/findkey.php', form: {name:username}}, function (error, response, body) {
			  console.log('error:', error); // Print the error if one occurred
			  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
			  console.log('body:', body); // Print the HTML for the Google homepage.
			  let userarray = body.split(", ");
			  return message.author.send(`Your login name is: **`+userarray[0]+`**`+" your key is: **"+userarray[1]+"**");
			});
	}
	if(cmd === `${prefix}whosonline` || cmd === `${prefix}whoisonline`){
        message.delete(500) // ?
		var request = require('request');
		request.post({url:'https://tholr.online/inc/whosonline.php'}, function (error, response, body) {
		  console.log('error:', error); // Print the error if one occurred
		  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
		  console.log('body:', body); // Print the HTML for the Google homepage.
		  
		  let usersarray = body.split(", ");
		  let namearray = [];
		  if(body !== ""){
			async function asyncCall() {
				var promises = [];
				usersarray.forEach(user=>promises.push(bot.fetchUser(user)));
				var arrayOfFetchedUsers = await Promise.all(promises);
				for(user of arrayOfFetchedUsers){
					namearray.push(user.username);
				}
				return message.channel.send(namearray.join(", "));
				
			}
			asyncCall();
		  }else{
				return message.channel.send("Nobody is online");
		  }
		  //return message.channel.send(`${usertags}`);
		});

	}
	if(cmd === `${prefix}onlinecount`){
        message.delete(500) // ?
		var request = require('request');
		request.post({url:'https://tholr.online/inc/whosonline.php?action=count'}, function (error, response, body) {
		  console.log('error:', error); // Print the error if one occurred
		  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
		  console.log('body:', body); // Print the HTML for the Google homepage.
		  
		  var suffix = "s";
		  if(body == 1){
			  var suffix = "";
		  }
		  return message.channel.send(body+" player"+suffix+" online");
		});
	}
	if(cmd === `${prefix}ban`){
        message.delete(500) // ?
		if(!message.member.roles.find(x => x.name === "Team")) return message.channel.send("You do not have permission for this!");
		var gRole = message.member.roles.find(x => x.name === "Team");
		if(!gRole) return message.reply("Couldn't find that role.");
		if(gRole.id){
			let amUser = message.guild.member(message.mentions.users.first() || message.guild.members.get(args[0]));
			if (!amUser) return message.channel.send("Cannot find User");
			var request = require('request');
			var discord = message.guild.member(amUser).id;
			console.log(discord);
			request.post({url:'https://tholr.online/inc/banuser.php', form: {d_name:discord,value:1}}, function (error, response, body) {
			  console.log('error:', error); // Print the error if one occurred
			  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
			  console.log('body:', body); // Print the HTML for the Google homepage.
			  
			  return message.channel.send(body);
			});
		}
	}
	if(cmd === `${prefix}unban`){
        message.delete(500) // ?
		if(!message.member.roles.find(x => x.name === "Team")) return message.channel.send("You do not have permission for this!");
		var gRole = message.member.roles.find(x => x.name === "Team");
		if(!gRole) return message.reply("Couldn't find that role.");
		if(gRole.id){
			let amUser = message.guild.member(message.mentions.users.first() || message.guild.members.get(args[0]));
			if (!amUser) return message.channel.send("Cannot find User");
			var request = require('request');
			var discord = message.guild.member(amUser).id;
			console.log(discord);
			request.post({url:'https://tholr.online/inc/banuser.php', form: {d_name:discord,value:0}}, function (error, response, body) {
			  console.log('error:', error); // Print the error if one occurred
			  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
			  console.log('body:', body); // Print the HTML for the Google homepage.
			  
			  return message.channel.send(body);
			});
		}
	}	
});
bot.login(botconfig.token);