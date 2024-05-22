-- Load the shader
local shader = g_shaders.createShader("movementShader", {
    vertex = "/data/shaders/movementShader.vert",
    fragment = "/data/shaders/movementShader.frag"
})

-- Variables to track the player's last position
local lastPosition = nil

-- Function to update the shader's time uniform
local function updateEffectShader()
    local time = g_clock.millis() / 1000
    shader:setUniformValue("time", time)
    shader:setUniformValue("resolution", { g_window.getWidth(), g_window.getHeight() })
end

-- Function to check if the player has moved
local function onPlayerMove()
    local player = g_game.getLocalPlayer()
    if player then
        local currentPosition = player:getPosition()
        if lastPosition == nil or not currentPosition:isEqual(lastPosition) then
            -- Player has moved, update the shader
            updateEffectShader()
            lastPosition = currentPosition
        end
    end
end

-- Connect the onPlayerMove function to the onGameTick event
connect(g_game, { onGameTick = onPlayerMove })

-- Apply the shader
g_shaders.useShader(shader)