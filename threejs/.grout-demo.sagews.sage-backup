︠26dcf45b-40d9-4f64-8767-a275c1cd6588︠
%html(hide=False)

<script src="https://raw.github.com/mrdoob/three.js/master/build/three.min.js"></script>

<script src="https://raw.github.com/mrdoob/three.js/master/examples/js/loaders/OBJLoader.js"></script>

<script src="http://sage.math.washington.edu/home/jason/three.js/tinytrackball/TinyTrackballControls.js"></script>
︡2b20951f-481b-4f67-8f36-a8f1bc44c5c8︡{"html":"\n<script src=\"https://raw.github.com/mrdoob/three.js/master/build/three.min.js\"></script>\n\n<script src=\"https://raw.github.com/mrdoob/three.js/master/examples/js/loaders/OBJLoader.js\"></script>\n\n<script src=\"http://sage.math.washington.edu/home/jason/three.js/tinytrackball/TinyTrackballControls.js\"></script>"}︡
︠7554c6b3-935c-4954-97dc-f17ca8e5a88d︠
%var x y
p = plot3d(sin(x*y),(x,-1,1), (y,-1,1))
︡747c5fc7-178d-4e50-b540-391e87bd8f07︡
︠64241715-96f6-4dca-9b37-b279932adb78︠
import os, uuid
def render(p):
    # Save rendered 3d scene to a temporary file
    # TODO: there is no color information here yet -- see docs for .obj.
    filename = str(uuid.uuid4()) + '.obj'
    open(filename,'w').write(p.obj())

    # Get URL to the file
    obj_url = salvus.file(filename, show=False)

    # It is now safe to remove the file from disk
    os.unlink(filename)

    # Call javascript to display the given link.
    print obj_url

︡bf734e91-c954-4ea6-9e3d-ecf6bd0cc4a5︡
︠ab751bcd-1422-4979-9dd6-2f9c27e385c7︠
render(p)
︡47f27b10-6437-4ea7-a952-38a4d8195606︡{"file":{"show":false,"uuid":"3eef21f0-f9d6-40f2-8773-f696a5e30af7","filename":"68952ddd-ab9e-4666-829e-6142d99ba9c8.obj"}}︡{"stdout":"/blobs/68952ddd-ab9e-4666-829e-6142d99ba9c8.obj?uuid=3eef21f0-f9d6-40f2-8773-f696a5e30af7\n"}︡
︠bdaeddc0-8560-4ec8-81b8-40667538ad77︠

︠a09339b2-7c55-4ad2-b695-f6e5b32afabd︠

︠97e2718f-6b74-4cda-a83e-e5a0c90ab0b5︠


    html("""
    <div id="plot-%(uuid)s" style="width:700px;height:400px;border:solid 1px"></div>
    <script>
    setTimeout(function() {
    // check capabilities, and start if sufficient
    var haswebgl = (function() {try {return !! window.WebGLRenderingContext &&
            !! document.createElement('canvas').getContext('experimental-webgl');}
            catch(e){return false;}})();

    var hascanvas = !! window.CanvasRenderingContext2D;

    if(hascanvas) {
        var contextR, contextW;
        document.addEventListener( "DOMContentLoaded", init, false);
    }

    var item = {};
    function init() {
        /* spawns the objects, scenes, cameras, renderers etc. */
            // set the scene
            var width = 700;
            var height=400;
            if (haswebgl) {
                //item.renderer = new THREE.WebGLRenderer();
                item.renderer = new THREE.WebGLRenderer({antialias:true});
            } else {
                item.renderer = new THREE.CanvasRenderer();
            }
            item.renderer.setSize(width,height);
            item.scene = new THREE.Scene();
            item.camera = new THREE.PerspectiveCamera(45, width/height, 2, 1000);
            item.camera.position = new THREE.Vector3(10,10,10);
            item.scene.add(item.camera);
            item.controls = new THREE.TinyTrackballControls(item.camera, item.renderer.domElement);
            item.controls.target.set(0, 0, 0);
            //item.controls.noZoom = true;
            //item.controls.noPan = true;
            var loader = new THREE.OBJLoader();
            loader.load( "%(url)s", function ( object ) {
                myobj=object.children[0];
                var mesh = new THREE.SceneUtils.createMultiMaterialObject(myobj.geometry,
                   [new THREE.MeshBasicMaterial({color: 0x6666ff}),
                    new THREE.MeshBasicMaterial({ color: 0x000000, wireframe: true, transparent: true, opacity: 0.5 } )] );
                item.scene.add(mesh);
             });

            // add the renderer to the document
            div=document.getElementById("plot-%(uuid)s")
            if (div.firstChild) {
                div.replaceChild(item.renderer.domElement,div.firstChild);
            } else {
                div.appendChild(item.renderer.domElement);
            }
        animate();
    }

    function animate() {
        /* one animation tick */
        requestAnimationFrame(animate);
        item.controls.update();
        myrender();
    }

    function myrender () {
        /* renders our little scene */
        item.renderer.render(item.scene, item.camera);
    }
    init()
    },100);
    """%{'url':WORKSHEET_URL+'cells/'+str(sagenb.notebook.interact.SAGE_CELL_ID)+'/'+filename,'uuid':uuid}+"</script>")