︠4342b9aa-597d-4074-9c2f-07e1f456bc25i︠
%html
<div id="3d">Output</div>
︡c547b46d-9b31-47ce-b56c-af321f77fde7︡{"html":"<div id=\"3d\">Output</div>"}︡
︠b70cd535-c419-4c9a-8392-de4bb70af03a︠
%javascript

var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
var renderer = new THREE.WebGLRenderer();
renderer.setSize(.5*window.innerWidth, .5*window.innerHeight);
$("#3d").empty().append(renderer.domElement);

var geometry = new THREE.CubeGeometry(1,1,1);
var material = new THREE.MeshBasicMaterial({color: 0x0000ff});
var cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

var render = function () {
    requestAnimationFrame(render);

    cube.rotation.x += 0.1;
    cube.rotation.y += 0.1;

    renderer.render(scene, camera);
};

render();
︡b5573e6d-298c-4f09-9ef8-1d9dd4ae4fad︡{"obj":"{}","javascript":{"coffeescript":false,"code":"\nvar scene = new THREE.Scene();\nvar camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);\nvar renderer = new THREE.WebGLRenderer();\nrenderer.setSize(.5*window.innerWidth, .5*window.innerHeight);\n$(\"#3d\").empty().append(renderer.domElement);\n\nvar geometry = new THREE.CubeGeometry(1,1,1);\nvar material = new THREE.MeshBasicMaterial({color: 0x0000ff});\nvar cube = new THREE.Mesh(geometry, material);\nscene.add(cube);\n\ncamera.position.z = 5;\n\nvar render = function () {\n    requestAnimationFrame(render);\n\n    cube.rotation.x += 0.1;\n    cube.rotation.y += 0.1;\n\n    renderer.render(scene, camera);\n};\n\nrender();"},"once":true}︡
︠150a4566-8b7d-437b-bad7-811f962ff8e6︠
