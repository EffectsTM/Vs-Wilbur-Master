function start (song)  -- do nothing

end

function update (elapsed) -- example https://twitter.com/KadeDeveloper/status/1382178179184422918
    if curStep > 496 then
		tweenCameraZoom(1.5,(crochet * 4) / 100)
		local currentBeat = (songPos / 496)*(bpm/150)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 25 * math.sin((currentBeat + i*0.5) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.5) * math.pi), i)
    if curStep > 538 then
		tweenCameraZoom(1,(crochet * 1) / 50)
		   end
		end
	end
end

function beatHit (beat)
   -- do nothing
end

function stepHit (step)
	
end

print("Mod Chart script loaded :)")