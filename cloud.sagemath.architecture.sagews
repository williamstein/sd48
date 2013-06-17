︠40242466-e29c-4923-bff0-903e0f2ccfcbi︠
%md
# The Architecture of <https://cloud.sagemath.com>
## William Stein
### June 18, 2013 (Sage Days 48)
︡0e0fb33e-c207-4a05-9de7-250ff6b0c830︡{"html":"<h1>The Architecture of <a href=\"https://cloud.sagemath.com\">https://cloud.sagemath.com</a></h1>\n\n<h2>William Stein</h2>\n\n<h3>June 18, 2013 (Sage Days 48)</h3>\n"}︡
︠fe8a7d61-0fcc-4e95-82af-b3b5119469c8i︠

%md
## Diagram

<http://sketchboard.me/zyjdkavkLucN>

<img src="http://www.aegisengineering.com/wp-content/uploads/2012/12/UW-Tower2.jpg">
︡631d76d3-c376-4093-ab7a-e4683a159766︡{"html":"<h2>Diagram</h2>\n\n<p><a href=\"http://sketchboard.me/zyjdkavkLucN\">http://sketchboard.me/zyjdkavkLucN</a></p>\n\n<p><img src=\"http://www.aegisengineering.com/wp-content/uploads/2012/12/UW-Tower2.jpg\"></p>\n"}︡
︠a9573dd4-c293-4dd9-9aac-c4358f2f6c54︠
salvus.file("arch.png")
︡de07f3d8-b9a6-4cb2-a7f5-fbe5a673d031︡{"file":{"show":true,"uuid":"bff074c3-20b0-4dfc-8b7e-c8cca09e9c73","filename":"arch.png"}}︡
︠620fffc0-a29e-406b-83b4-58443c961217︠
%md
## Design Goals

 - Eventually scale to one million users (10,000 at once)
 - No single points of failure  (SPOF)
 -



