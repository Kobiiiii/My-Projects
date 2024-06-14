require('dotenv').config() //Using all the objects from the dotenv library.


const { Client, GatewayIntentBits, Component, Message, Guild, Embed, User, ClientUser, StringSelectMenuBuilder, TextInputBuilder, TextInputStyle, ModalBuilder, ModalSubmitInteraction } = require('discord.js'); //Using the objects from the js library.
const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
    GatewayIntentBits.GuildMessageTyping
  ]
}) //Telling discord your intents on what the bot is going to do.

const { ActionRowBuilder, ButtonBuilder, ButtonStyle, EmbedBuilder, Event} = require('discord.js');

client.on('ready', () =>  (console.log("LESS GO!!!"))) // "ready function."


client.on('messageCreate', (msg) => {

  if (msg.content.toLowerCase() === "f") {
    // Create a new button.
    const ratings = new ActionRowBuilder()
      .addComponents(
        new ButtonBuilder()
          .setCustomId('Button 1')
          .setLabel('1')
          .setStyle(ButtonStyle.Primary),

        new ButtonBuilder()
          .setCustomId('button 2')
          .setLabel('2')
          .setStyle(ButtonStyle.Primary),

        new ButtonBuilder()
          .setCustomId('button 3')
          .setLabel('3')
          .setStyle(ButtonStyle.Primary),

        new ButtonBuilder()
          .setCustomId('button 4')
          .setLabel('4')
          .setStyle(ButtonStyle.Primary),
        
        new ButtonBuilder()
          .setCustomId('button 5')
          .setLabel('5')
          .setStyle(ButtonStyle.Primary)
      );

          
    const exampleEmbed = new EmbedBuilder()
      .setColor(0x24c6ff)
      .setAuthor({name: `Hi ` + msg.author.username, iconURL: client.user.displayAvatarURL()})
      .setTitle("Would you like to give this server some feedback?")
      .setThumbnail(`https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/SSU_Kirby_artwork.png/220px-SSU_Kirby_artwork.png`)
      .setDescription(`Click the numbers 1 (bad) to 5 (good) to give us your rating on the server and give us feedback on the server based on your rating.`);


    msg.channel.send({
      content: null,
      components: [ratings],
      ephemeral: false,
      embeds: [exampleEmbed]
    });
  }
})

client.on('interactionCreate', (interaction) => { // Checking for every interatction of the bot.
  if (interaction.customId == "Button 1" || interaction.customId == "button 2" || interaction.customId == "button 3" || interaction.customId == "button 4" || interaction.customId == "button 5") {
    
    // Create a new modal.
    const giveusFeedback = new ModalBuilder()
      .setCustomId('Feedback Modal')
      .setTitle('Giving Us Feedback!')
    
    // Creates a new text input.
    const feedback = new TextInputBuilder()
      .setCustomId('why')
      .setLabel('Why have you chosen this option?')
      .setStyle(TextInputStyle.Paragraph)
      .setPlaceholder('Put your reasoning here.')

    // Creates a actionRow for the feedback text input.
    const firstActionRow = new ActionRowBuilder().addComponents(feedback)

    // Gives the modal the firstactionrow component.
    giveusFeedback.addComponents(firstActionRow)

    // Shows the created modal after the interation has been checked.
    interaction.showModal(giveusFeedback)
  }

  if (interaction.isModalSubmit()){
    const modChannel = client.channels.cache.get('1127994362861715556');
    const feed = interaction.fields.getTextInputValue('why')

    interaction.reply('Thank you for your feedback!')

    modChannel.send({
      content: feed
    })

  }
});


client.login('Empty for privacy reasons');