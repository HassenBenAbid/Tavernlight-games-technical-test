--Q1

local function releaseStorage(player)
    --We make sure to only call the setStorageValue when the object passed to this function is actually a player.
    if player then
        player:setStorageValue(1000, -1)
    else
        print("Error: Invalid player object.");
    end
end
    
--This function will get called whenever a player logout.
function onLogout(player)
    --If the object passed to this function isn't a player then no logout has happened and we return false.
    if not player then
        print("Error: Invalid player object.");
        return false;
    end

    --If the storage with the specified id is enabled (set to 1) then we want to release it upon player logout.
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player) --We release the storage after a delay of 1s(1000ms).
    end

    return true
end

--Q2

function printSmallGuildNames(memberCount)
    --First we try to get all the guilds that have less than memberCount max members.
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId         = db.storeQuery(string.format(selectGuildQuery, memberCount))

    --If there's at least one guild that respect that condition, then we iterate through all the guilds and each time we print the name.
    if resultId then
        repeat
            local guildName = resultId:getString("name");
            print(guildName);
        until not resultId:next()
    else
        print("Error: No guilds found with less than ".. memberCount .." members.");
    end
end

--Q3

--This will take take of removing a specified member from the specified player's party.
--We return true if a member was removed.
function RemoveMemberFromPlayerParty(playerId, membername)
    --We try to get the player with the specified id.
    player = Player(playerId)
    if not player then
        print("Error: No player with ID ".. playerId .." was found.");
        return false;
    end

    --We make sure that the member that we want to remove actually exist as a player.
    memberToRemove = Player(membername);
    if not memberToRemove then
        print("Error: No player with the name " .. membername .. " was found.");
        return false;
    end

    --We try to get the player's party.
    local party = player:getParty()
    if not party then
        print("Error: Player isn't part of a party.");
        return false;
    end
    
    --We go through all the players that are currently in the party and remove the specified one if found.
    for k,member in pairs(party:getMembers()) do
        if member == memberToRemove then
            party:removeMember(member);
            return true
        end 
    end

    return false; 
end