import bpy
from io_scene_3dsobj import import_3ds_obj

import os


# configuration
modelbank = "/model/directory/here"
outDir = "/output/directory/here"

# get list of all models to render
models = os.listdir(modelbank)

# don't rerender already rendered models
blacklist = os.listdir(outDir)

if not os.path.exists(outDir):
    os.makedirs(outDir)

for model in models:
    if model in blacklist:
        continue
    # select all meshes and delete
    bpy.ops.object.select_by_type(type='MESH')
    bpy.ops.object.delete()
    
    # load mesh to render
    print("Loading mesh: %s" % model)
    import_3ds_obj.load(None, bpy.context, modelbank + model + '/' + model + '.obj')
    
    # setup output directory
    dstDir = outDir + model + '/'
    if not os.path.exists(dstDir):
        os.makedirs(dstDir)
    
    # setup render
    bpy.data.scenes[0].render.file_format = 'PNG'
    bpy.data.scenes[0].render.filepath = dstDir + model + '.png'
    
    # render
    print("Rendering to: %s" % (dstDir + model + '.png'))
    bpy.ops.render.render(write_still=True)
    
