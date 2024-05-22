//Q4

/*A method that takes care of creating and adding a specified item type to the specified player.*/
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient); //We try to get player from the current game instance.

    //In case that wasn't possible then maybe the player is offline, we check our saved data.
    if (!player) {
        player = new Player(nullptr);

        if (!IOLoginData::loadPlayerByName(player, recipient)) { delete player; return;} //If we can't find the player ingame nor in our saved data then the player just doesn't exist. 
    }

    //We create an instance of the item that has this specified ID.
    Item* item = Item::CreateItem(itemId); 

    //Then we make sure to add it to the player.
    if (item)
    {
        g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
        if (player->isOffline()) IOLoginData::savePlayer(player); //If the player is currently offline, we make sure to store this in the player data. 
    }

    if (player->isOffline()) delete player; //If the player is offline that means that we dynamically created a new player here, we make sure to clean our mess.
}