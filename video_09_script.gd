@tool

extends Node3D


var surface_array = []

var verts = PackedVector3Array()
var uvs = PackedVector2Array()
var normals = PackedVector3Array()
var indices = PackedInt32Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	var mesh = $ArrMesh
	
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	# PackedVector**Arrays for mesh construction.
	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()

	verts.push_back(Vector3(1, 0, 1))
	verts.push_back(Vector3(1, 0, 0))
	verts.push_back(Vector3(0, 0, 1))
	
	indices.push_back(0)
	indices.push_back(1)
	indices.push_back(2)

	# Assign arrays to surface array.
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface from mesh array.
	# No blendshapes, lods, or compression used.
	mesh.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
