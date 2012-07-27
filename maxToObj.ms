--  1: Import file
--  2: Export file (as more widely supported or POVRay friendly file format)

convert = false -- set to true to convert all files, false to start at a certain file
startingID = "MB28731" -- 28731 failed
bankDir = "C:\\My 3D Models"
for mdir in (getDirectories(bankDir + "\\MB*")) do
(
	tokens = filterString mdir "\\"
	basename = tokens[tokens.count]
	if (basename == startingID) do convert = true
	if (convert == true) then (
		print ("Converting : " + basename)
		mapPaths.add mdir
		inFile = mdir + basename + ".3DS"
		outFile = mdir + basename + ".obj"
		resetMaxFile #noPrompt
		print "Loading 3ds"
		importFile inFile #noPrompt
		max views redraw
		exportFile outFile #noPrompt
		print "Rendering 3ds"
		render outputFile:(mdir + basename + "_3ds.bmp") vfb:off quiet:true #noPrompt
		resetMaxFile #noPrompt
		print "Loading obj"
		importFile outFile #noPrompt
		print "Rendering obj"
		render outputFile:(mdir + basename + "_obj.bmp") vfb:off quiet:true #noPrompt
		i = mapPaths.count()
		mapPaths.delete i
		convert = false -- set this to false to stop after 1 conversion
	) else (
		print ("Skipping : " + basename)
	)
)