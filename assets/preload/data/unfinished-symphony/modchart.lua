function start (song)  -- do nothing

end

function update (elapsed) -- example https://twitter.com/KadeDeveloper/status/1382178179184422918
    if curStep > 15 then
        local currentBeat = (songPos / 1000)*(bpm/150)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 20 * math.sin((currentBeat + i*2.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 15 * math.cos((currentBeat + i*2.25) * math.pi), i)
	end 
end

function beatHit (beat)
   -- do nothing
end

function stepHit (step)
		tweenCameraZoom(0.9,(crochet * 1) / 50)
	end
end

print("Mod Chart script loaded :)")