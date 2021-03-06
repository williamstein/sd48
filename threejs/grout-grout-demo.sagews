︠26dcf45b-40d9-4f64-8767-a275c1cd6588︠
%html(hide=False)

<script src="https://raw.github.com/mrdoob/three.js/master/build/three.js"></script>

<script src="https://raw.github.com/mrdoob/three.js/master/examples/js/loaders/OBJLoader.js"></script>

<script src="https://raw.github.com/mrdoob/three.js/master/examples/js/controls/TrackballControls.js"></script>

<script src="https://raw.github.com/mrdoob/three.js/master/examples/js/Detector.js"></script>

︡d958d4d5-8ac3-4577-a239-8e3a154a7002︡{"html":"\n<script src=\"https://raw.github.com/mrdoob/three.js/master/build/three.js\"></script>\n\n<script src=\"https://raw.github.com/mrdoob/three.js/master/examples/js/loaders/OBJLoader.js\"></script>\n\n<script src=\"https://raw.github.com/mrdoob/three.js/master/examples/js/controls/TrackballControls.js\"></script>\n\n<script src=\"https://raw.github.com/mrdoob/three.js/master/examples/js/Detector.js\"></script>"}︡
︠7554c6b3-935c-4954-97dc-f17ca8e5a88d︠
%var x y
p = plot3d(sin(x*y),(x,-1,1), (y,-1,1))
︡abf097f4-c8fa-46f6-adc6-6a095fe4bb0c︡
︠2f8c5d9b-12f3-4c72-9b0c-a83c9b047868︠
import os, uuid
def render(p):
    # Save rendered 3d scene to a temporary file
    # TODO: there is no color information here yet -- see docs for .obj.
    id = uuid.uuid4()
    filename = str(id) + '.obj'
    open(filename,'w').write(p.obj())

    # Get URL to the file
    obj_url = salvus.file(filename, show=False)

    # It is now safe to remove the file from disk
    os.unlink(filename)

    # Create div that will contain our 3d scene
    html("<div id=%s style='border:1px solid black'>"%id, hide=False)

    # Display the object
    s = "d=$('#%s'); d.data('three', new window.ThreeJSobj('%s', d))"%(id, obj_url)
    print s
    coffeescript(s)

    # TODO: what about garbage collection / memory leaks!?

︡172db1f6-f6d6-40db-8698-390e46629384︡
︠ab751bcd-1422-4979-9dd6-2f9c27e385c7︠
render(p)
︡71db7ee5-16f9-4ff3-a99f-ccf2425c2af5︡{"file":{"show":false,"uuid":"d88f3469-1096-4808-a57b-d3ef67e7f630","filename":"cfbb6c58-5bef-426f-8491-62201fa6880c.obj"}}︡{"html":"<div id=cfbb6c58-5bef-426f-8491-62201fa6880c style='border:1px solid black'>"}︡{"obj":"{}","javascript":{"coffeescript":true,"code":"d=$('#cfbb6c58-5bef-426f-8491-62201fa6880c'); d.data('three', new window.ThreeJSobj('/blobs/cfbb6c58-5bef-426f-8491-62201fa6880c.obj?uuid=d88f3469-1096-4808-a57b-d3ef67e7f630', d))"},"once":true}︡{"stdout":"d=$('#cfbb6c58-5bef-426f-8491-62201fa6880c'); d.data('three', new window.ThreeJSobj('/blobs/cfbb6c58-5bef-426f-8491-62201fa6880c.obj?uuid=d88f3469-1096-4808-a57b-d3ef67e7f630', d))\n"}︡
︠bdaeddc0-8560-4ec8-81b8-40667538ad77︠
%coffeescript

class ThreeJSobj
    constructor : (@url, @elt) ->
        # Spawns the objects, scenes, cameras, renderers etc.
        # set the scene
        width = 700
        height = 400
        @renderer = new THREE.WebGLRenderer(antialias: true)

        @renderer.setSize(width, height)
        @scene = new THREE.Scene()
        @camera = new THREE.PerspectiveCamera(45, width / height, 2, 1000)
        @camera.position = new THREE.Vector3(10, 10, 10)
        @scene.add(@camera)
        @controls = new THREE.TinyTrackballControls(@camera, @renderer.domElement)
        @controls.target.set(0, 0, 0)

        loader = new THREE.OBJLoader()
        loader.load @url, (object) ->
            myobj = object.children[0]
            mat1  = new THREE.MeshBasicMaterial(color: 0x6666ff)
            mat2  = new THREE.MeshBasicMaterial
                        color: 0x000000
                        wireframe: true
                        transparent: true
                        opacity: 0.5
            mesh  = new THREE.SceneUtils.createMultiMaterialObject(myobj.geometry, [mat1, mat2])
            @scene.add(mesh)

        # add the renderer to the document
        $(@elt).empty().append(@renderer.domElement)
        @animate()

    animate: () ->
        # one animation tick
        requestAnimationFrame(animate)
        @controls.update()
        @myrender()

    myrender: () ->
        # renders our scene
        @renderer.render(@scene, @camera)

window.ThreeJSobj = ThreeJSobj

︡88866fba-40b8-47a0-ba25-056bed4dbfd7︡{"obj":"{}","javascript":{"coffeescript":true,"code":"\nclass ThreeJSobj\n    constructor : (@url, @elt) ->\n        # Spawns the objects, scenes, cameras, renderers etc.\n        # set the scene\n        width = 700\n        height = 400\n        @renderer = new THREE.WebGLRenderer(antialias: true)\n\n        @renderer.setSize(width, height)\n        @scene = new THREE.Scene()\n        @camera = new THREE.PerspectiveCamera(45, width / height, 2, 1000)\n        @camera.position = new THREE.Vector3(10, 10, 10)\n        @scene.add(@camera)\n        @controls = new THREE.TinyTrackballControls(@camera, @renderer.domElement)\n        @controls.target.set(0, 0, 0)\n\n        loader = new THREE.OBJLoader()\n        loader.load @url, (object) ->\n            myobj = object.children[0]\n            mat1  = new THREE.MeshBasicMaterial(color: 0x6666ff)\n            mat2  = new THREE.MeshBasicMaterial\n                        color: 0x000000\n                        wireframe: true\n                        transparent: true\n                        opacity: 0.5\n            mesh  = new THREE.SceneUtils.createMultiMaterialObject(myobj.geometry, [mat1, mat2])\n            @scene.add(mesh)\n\n        # add the renderer to the document\n        $(@elt).empty().append(@renderer.domElement)\n        @animate()\n\n    animate: () ->\n        # one animation tick\n        requestAnimationFrame(animate)\n        @controls.update()\n        @myrender()\n\n    myrender: () ->\n        # renders our scene\n        @renderer.render(@scene, @camera)\n\nwindow.ThreeJSobj = ThreeJSobj"},"once":true}︡
︠a09339b2-7c55-4ad2-b695-f6e5b32afabd︠

︠97e2718f-6b74-4cda-a83e-e5a0c90ab0b5︠


    <div id="plot-%(uuid)s" style="width:700px;height:400px;border:solid 1px"></div>

%javascript
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


︠6cbafd42-cff6-4858-af24-07a73ec94cf6︠

%html(hide=False)

		<div id="container"></div>
		<div id="info">
			<a href="http://threejs.org" target="_blank">three.js</a> - trackball controls example
			MOVE mouse &amp; press LEFT/A: rotate, MIDDLE/S: zoom, RIGHT/D: pan
		</div>

		<!-- <script src="js/libs/stats.min.js"></script> -->

		<script>

			if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var container, stats;

			var camera, controls, scene, renderer;

			var cross;

			init();
			animate();

			function init() {

				camera = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 1, 1000 );
				camera.position.z = 500;

				controls = new THREE.TrackballControls( camera );

				controls.rotateSpeed = 1.0;
				controls.zoomSpeed = 1.2;
				controls.panSpeed = 0.8;

				controls.noZoom = false;
				controls.noPan = false;

				controls.staticMoving = true;
				controls.dynamicDampingFactor = 0.3;

				controls.keys = [ 65, 83, 68 ];

				controls.addEventListener( 'change', render );

				// world

				scene = new THREE.Scene();
				scene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );

				var geometry = new THREE.CylinderGeometry( 0, 10, 30, 4, 1 );
				var material =  new THREE.MeshLambertMaterial( { color:0xffffff, shading: THREE.FlatShading } );

				for ( var i = 0; i < 500; i ++ ) {

					var mesh = new THREE.Mesh( geometry, material );
					mesh.position.x = ( Math.random() - 0.5 ) * 1000;
					mesh.position.y = ( Math.random() - 0.5 ) * 1000;
					mesh.position.z = ( Math.random() - 0.5 ) * 1000;
					mesh.updateMatrix();
					mesh.matrixAutoUpdate = false;
					scene.add( mesh );

				}


				// lights

				light = new THREE.DirectionalLight( 0xffffff );
				light.position.set( 1, 1, 1 );
				scene.add( light );

				light = new THREE.DirectionalLight( 0x002288 );
				light.position.set( -1, -1, -1 );
				scene.add( light );

				light = new THREE.AmbientLight( 0x222222 );
				scene.add( light );


				// renderer

				renderer = new THREE.WebGLRenderer( { antialias: false } );
				renderer.setClearColor( scene.fog.color, 1 );
				renderer.setSize( window.innerWidth, window.innerHeight );

				container = document.getElementById( 'container' );
				container.appendChild( renderer.domElement );

				stats = new Stats();
				stats.domElement.style.position = 'absolute';
				stats.domElement.style.top = '0px';
				stats.domElement.style.zIndex = 100;
				container.appendChild( stats.domElement );

				//

				window.addEventListener( 'resize', onWindowResize, false );

			}

			function onWindowResize() {

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

				controls.handleResize();

				render();

			}

			function animate() {

				requestAnimationFrame( animate );
				controls.update();

			}

			function render() {

				renderer.render( scene, camera );
				stats.update();

			}


		</script>
︡cf1b1b96-6092-429c-9911-31f01fd39753︡{"html":"\n\t\t<div id=\"container\"></div>\n\t\t<div id=\"info\">\n\t\t\t<a href=\"http://threejs.org\" target=\"_blank\">three.js</a> - trackball controls example\n\t\t\tMOVE mouse &amp; press LEFT/A: rotate, MIDDLE/S: zoom, RIGHT/D: pan\n\t\t</div>\n\n\t\t<!-- <script src=\"js/libs/stats.min.js\"></script> -->\n\n\t\t<script>\n\n\t\t\tif ( ! Detector.webgl ) Detector.addGetWebGLMessage();\n\n\t\t\tvar container, stats;\n\n\t\t\tvar camera, controls, scene, renderer;\n\n\t\t\tvar cross;\n\n\t\t\tinit();\n\t\t\tanimate();\n\n\t\t\tfunction init() {\n\n\t\t\t\tcamera = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 1, 1000 );\n\t\t\t\tcamera.position.z = 500;\n\n\t\t\t\tcontrols = new THREE.TrackballControls( camera );\n\n\t\t\t\tcontrols.rotateSpeed = 1.0;\n\t\t\t\tcontrols.zoomSpeed = 1.2;\n\t\t\t\tcontrols.panSpeed = 0.8;\n\n\t\t\t\tcontrols.noZoom = false;\n\t\t\t\tcontrols.noPan = false;\n\n\t\t\t\tcontrols.staticMoving = true;\n\t\t\t\tcontrols.dynamicDampingFactor = 0.3;\n\n\t\t\t\tcontrols.keys = [ 65, 83, 68 ];\n\n\t\t\t\tcontrols.addEventListener( 'change', render );\n\n\t\t\t\t// world\n\n\t\t\t\tscene = new THREE.Scene();\n\t\t\t\tscene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );\n\n\t\t\t\tvar geometry = new THREE.CylinderGeometry( 0, 10, 30, 4, 1 );\n\t\t\t\tvar material =  new THREE.MeshLambertMaterial( { color:0xffffff, shading: THREE.FlatShading } );\n\n\t\t\t\tfor ( var i = 0; i < 500; i ++ ) {\n\n\t\t\t\t\tvar mesh = new THREE.Mesh( geometry, material );\n\t\t\t\t\tmesh.position.x = ( Math.random() - 0.5 ) * 1000;\n\t\t\t\t\tmesh.position.y = ( Math.random() - 0.5 ) * 1000;\n\t\t\t\t\tmesh.position.z = ( Math.random() - 0.5 ) * 1000;\n\t\t\t\t\tmesh.updateMatrix();\n\t\t\t\t\tmesh.matrixAutoUpdate = false;\n\t\t\t\t\tscene.add( mesh );\n\n\t\t\t\t}\n\n\n\t\t\t\t// lights\n\n\t\t\t\tlight = new THREE.DirectionalLight( 0xffffff );\n\t\t\t\tlight.position.set( 1, 1, 1 );\n\t\t\t\tscene.add( light );\n\n\t\t\t\tlight = new THREE.DirectionalLight( 0x002288 );\n\t\t\t\tlight.position.set( -1, -1, -1 );\n\t\t\t\tscene.add( light );\n\n\t\t\t\tlight = new THREE.AmbientLight( 0x222222 );\n\t\t\t\tscene.add( light );\n\n\n\t\t\t\t// renderer\n\n\t\t\t\trenderer = new THREE.WebGLRenderer( { antialias: false } );\n\t\t\t\trenderer.setClearColor( scene.fog.color, 1 );\n\t\t\t\trenderer.setSize( window.innerWidth, window.innerHeight );\n\n\t\t\t\tcontainer = document.getElementById( 'container' );\n\t\t\t\tcontainer.appendChild( renderer.domElement );\n\n\t\t\t\tstats = new Stats();\n\t\t\t\tstats.domElement.style.position = 'absolute';\n\t\t\t\tstats.domElement.style.top = '0px';\n\t\t\t\tstats.domElement.style.zIndex = 100;\n\t\t\t\tcontainer.appendChild( stats.domElement );\n\n\t\t\t\t//\n\n\t\t\t\twindow.addEventListener( 'resize', onWindowResize, false );\n\n\t\t\t}\n\n\t\t\tfunction onWindowResize() {\n\n\t\t\t\tcamera.aspect = window.innerWidth / window.innerHeight;\n\t\t\t\tcamera.updateProjectionMatrix();\n\n\t\t\t\trenderer.setSize( window.innerWidth, window.innerHeight );\n\n\t\t\t\tcontrols.handleResize();\n\n\t\t\t\trender();\n\n\t\t\t}\n\n\t\t\tfunction animate() {\n\n\t\t\t\trequestAnimationFrame( animate );\n\t\t\t\tcontrols.update();\n\n\t\t\t}\n\n\t\t\tfunction render() {\n\n\t\t\t\trenderer.render( scene, camera );\n\t\t\t\tstats.update();\n\n\t\t\t}\n\n\n\t\t</script>"}︡
︠b6129cfb-6982-49b1-b1aa-d8fe685a8316︠

