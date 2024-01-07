	local cfg = Awesome.Config
	local postDownload = Awesome.postDownload
	local downloadDir = cfg.downloadDir
	local soundFormat = cfg.FileFormatVLURL
	local voiceLineURL = cfg.voiceLineURL
	
	if (!file.IsDir(downloadDir .. "postd_mat/", "DATA")) then
			file.CreateDir(downloadDir .. "postd_mat/")
	end
	
	if (!file.IsDir(downloadDir .. "postd_sound/", "DATA")) then
			file.CreateDir(downloadDir .. "postd_sound/")
	end
	

	function postDownload.DownloadImage(url, folder, useProxy)
		local id = util.CRC(url)
		local folder = tostring(folder)
		local material
		
		if (!file.IsDir(downloadDir .. "postd_mat/" .. folder .. "/", "DATA")) then
			file.CreateDir(downloadDir .. "postd_mat/" .. folder .. "/")
	    end
		
		local filepath = downloadDir .. "postd_mat/" .. folder .. "/" .. id .. "."

		local baseurl = useProxy and "https://proxy.duckduckgo.com/iu/?u=" .. url or url
		
		http.Fetch(baseurl, function( body, length, headers, code )
		
			if !body then material = Material("nil") return material end
			
			local ct = headers["Content-Type"] --image/png
		    ct =  ct:sub(ct:find("/")-ct:len())
			
			file.Write( filepath .. ct, body )
			material = Material( "../data/" .. filepath .. ct, "noclamp smooth" )
			return material
			
		end, function(error)
		
			if useProxy then material = Material("nil") return material end
			return postDownload.DownloadImage(url, folder, true)
			
		end)
		
	return material	
	end
	
	
	function postDownload.GetDownloadedImage(url, folder, fileFormat) --fileFormatEx = .png
		local id = util.CRC(url)		
		local filepath = downloadDir .. "postd_mat/" .. util.CRC(folder) .. "/" .. id .. fileFormat
		local material
		
		if (file.Exists(filepath, "DATA")) then
		
			return Material("../data/" .. filepath, "noclamp smooth")
		else

			return postDownload.DownloadImage(url, util.CRC(folder))
		end
	end






	
	function postDownload.DownloadSound(pathPart)
	
		local name = pathPart:sub(pathPart:find("/")-pathPart:len("/"))
		local folder = pathPart:sub(0,pathPart:find("/")-1)
		
		local sound = Sound("npc/combine_soldier/vo/_comma.wav")
		
		if (!file.IsDir(downloadDir .. "postd_sound/" .. folder .. "/", "DATA")) then
			file.CreateDir(downloadDir .. "postd_sound/" .. folder .. "/")
	    end
		
		local filepath = downloadDir .. "postd_sound/" .. folder .. "/" .. name .. soundFormat
		local url = voiceLineURL .. pathPart .. soundFormat
		
		http.Fetch(url, function( body, length, headers, code )
		
			if !body then return sound end
			
			file.Write( filepath, body )
			if  file.Exists(filepath, "DATA")  and file.Size(filepath, "DATA") >= length then
				sound = Sound( "../data/" .. filepath)
				return sound
			else
				file.Delete( filepath )
				return sound
	        end
			
		end, function(error)			
		end)
		
	return sound	
	end
	
	
	function postDownload.GetDownloadedSound(pathPart) --fileFormatEx = .wav
	
		local name = pathPart:sub(pathPart:find("/")-pathPart:len("/"))
		local folder = pathPart:sub(0,pathPart:find("/")-1)
		
		local filepath = downloadDir .. "postd_sound/" .. folder .. "/" .. name .. soundFormat
		local sound
		
		if (file.Exists(filepath, "DATA")) then
		
			return Sound( "../data/" .. filepath)
		else

			return postDownload.DownloadSound(pathPart, folder)
		end
	end