local combat = Combat()

function onCastSpell(creature, variant)
    local startPos = creature:getPosition() --We get the player position.
    local effect   = CONST_ME_ICETORNADO
    local size     = 5;                     --We choose the range that we want the effect to attend.

    --We create multiple Rhombus inside each other.
    for currentSize = size, 1, -1 do
        local effectPosition = createRhombusPoints(startPos, currentSize); --We create the Rhombus.
        --Then we make sure to spawn the specified effect on the right position.
        for _,position in ipairs(effectPosition) do
            if position ~= startPos then 
                addEvent(function() position:sendMagicEffect(effect) end, (size - currentSize) * 150)
            end
        end
    end

    return combat:execute(creature, variant)
end

--This will allow us to create all the points on the borders of a Rhombus.
function createRhombusPoints(center, size)
    local borderPoints = {}
    local realSize     = size - 1 --to get the right size (a square of the specified size) we need to substract 1.

    --We generate the right amount of points on each row.
    for y = center.y - realSize, center.y + realSize do
        --We calculate the horizontal borders at the current y position. 
        local deltaX = realSize - math.abs(y - center.y)
        local xMin = center.x - deltaX
        local xMax = center.x + deltaX

        --Then we add them to our table.
        table.insert(borderPoints, Position(xMin, y, center.z))
        table.insert(borderPoints, Position(xMax, y, center.z))
    end

    return borderPoints
end


