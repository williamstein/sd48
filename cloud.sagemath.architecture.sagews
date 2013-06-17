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
︡91beab5b-2d5d-4506-9350-5f88c36c5b0b︡{"file":{"show":true,"uuid":"bff074c3-20b0-4dfc-8b7e-c8cca09e9c73","filename":"arch.png"}}︡
︠620fffc0-a29e-406b-83b4-58443c961217i︠
%md
## Design Goals

 - **Scalability** Scale to one million users (10,000 at once)

     - Ads are illegal, so services can't be free at that level.

     - All components must be asynchronous and horizontally scalable.

 - **No SPOF's** No single points of failure

 - **Safety** User should have access to their data, and not loose work


**Status:** None have been reached yet.








︡68fc6447-f199-45b9-b69f-10dcc21718f5︡{"html":"<h2>Design Goals</h2>\n\n<ul>\n<li><p><strong>Scalability</strong> Scale to one million users (10,000 at once)</p>\n\n<ul>\n<li><p>Ads are illegal, so services can&#8217;t be free at that level.</p></li>\n<li><p>All components must be asynchronous and horizontally scalable.</p></li>\n</ul></li>\n<li><p><strong>No SPOF&#8217;s</strong> No single points of failure</p></li>\n<li><p><strong>Safety</strong> User should have access to their data, and not loose work</p></li>\n</ul>\n\n<p><strong>Status:</strong> None have been reached yet.</p>\n"}︡
︠32c0f202-49a5-4bc4-8385-9ee8a47ce717i︠
%md
## Technology

 - Database: Cassandra

 - VPN: Tinc, a peer-to-peer virtual private network

 - https: stunnel

 - load balancing: haproxy

 - Virtual machine management: KVM + custom Python scripts + Paramiko

 - Static http server: Nginx

 - Dynamic websocket server: Node.js + Sock.js + a Node.js program called "hub"; coordinates all users connecting with local hubs, editing documents, settings, sharing, permissions, account creation, caching blobs, etc.

 - local per-project TCP socket server: Node.js program called "localhub"; coordinates file editing, terminals, sage sessions, etc. for a single project

 - Sage server: a new Python program I wrote (forking tcp socket server with a token for access)

 - PTY server: a node.js program that supports text terminals.
















︡8f473ddb-9feb-47fd-8dcb-2b7f52a70572︡{"html":"<h2>Technology</h2>\n\n<ul>\n<li><p>Database: Cassandra</p></li>\n<li><p>VPN: Tinc, a peer-to-peer virtual private network</p></li>\n<li><p>https: stunnel</p></li>\n<li><p>load balancing: haproxy</p></li>\n<li><p>Virtual machine management: KVM + custom Python scripts + Paramiko</p></li>\n<li><p>Static http server: Nginx</p></li>\n<li><p>Dynamic websocket server: Node.js + Sock.js + a Node.js program called &#8220;hub&#8221;; coordinates all users connecting with local hubs, editing documents, settings, sharing, permissions, account creation, caching blobs, etc.</p></li>\n<li><p>local per-project TCP socket server: Node.js program called &#8220;localhub&#8221;; coordinates file editing, terminals, sage sessions, etc. for a single project</p></li>\n<li><p>Sage server: a new Python program I wrote (forking tcp socket server with a token for access)</p></li>\n<li><p>PTY server: a node.js program that supports text terminals.</p></li>\n</ul>\n"}︡
︠469a689d-ea5d-41c7-9c28-cf0a5643ad6ci︠

%md

## Code

 - Python for Sage-related stuff and admin/deployment/control

 - Node.js / CoffeeScript for everything else

 - At this point, every single line of code was written by me.

### License

- Some Python code is GPL'd since it imports things from Sage.

- Some Python code could be BSD licensed, but I haven't sorted that out yet.

- The localhub CoffeeScript code is BSD licensed.

- Everything else is closed source right now, including the client code.

### Size

    ~/salvus/salvus\$ cat *.py *.coffee page/*.coffee page/*.html page/*.css |wc -l
    39640

    ~/salvus/salvus\$ cat *.py |wc -l
    7307











︡496aeab3-d63a-4c86-994d-3303a8f1b66d︡{"html":"<h2>Code</h2>\n\n<ul>\n<li><p>Python for Sage-related stuff and admin/deployment/control</p></li>\n<li><p>Node.js / CoffeeScript for everything else</p></li>\n<li><p>At this point, every single line of code was written by me.</p></li>\n</ul>\n\n<h3>License</h3>\n\n<ul>\n<li><p>Some Python code is GPL&#8217;d since it imports things from Sage.</p></li>\n<li><p>Some Python code could be BSD licensed, but I haven&#8217;t sorted that out yet.</p></li>\n<li><p>The localhub CoffeeScript code is BSD licensed.</p></li>\n<li><p>Everything else is closed source right now, including the client code.</p></li>\n</ul>\n\n<h3>Size</h3>\n\n<pre><code>~/salvus/salvus\\$ cat *.py *.coffee page/*.coffee page/*.html page/*.css |wc -l\n39640\n\n~/salvus/salvus\\$ cat *.py |wc -l\n7307\n</code></pre>\n"}︡
︠0b91566f-f0e0-4d9b-b291-4d5355130cb2i︠
%md

## Comparison with sagenb

### Missing Features (sagenb has these, but cloud.sagemath doesn't)

 - Completely open source (GPL)

 - Documentation

 - Interactive 3d graphics

 - Public browsing of projects (like publishing a worksheet)

 - Import and export of Sage worksheets (sws files)

 - Many little things:

    - handling large output
    - general optimization of the worksheet
    - nice view of documentation (introspection)


︡7e7337d7-432b-49ff-88d1-46dc2de54f2a︡{"html":"<h2>Comparison with sagenb</h2>\n\n<h3>Missing Features (sagenb has these, but cloud.sagemath doesn&#8217;t)</h3>\n\n<ul>\n<li><p>Completely open source (GPL)</p></li>\n<li><p>Documentation</p></li>\n<li><p>Interactive 3d graphics</p></li>\n<li><p>Public browsing of projects (like publishing a worksheet)</p></li>\n<li><p>Import and export of Sage worksheets (sws files)</p></li>\n<li><p>Many little things:</p>\n\n<ul>\n<li>handling large output</li>\n<li>general optimization of the worksheet</li>\n<li>nice view of documentation (introspection)</li>\n</ul></li>\n</ul>\n"}︡
︠bfb9306b-37a0-479f-b445-c52aeddafd89i︠

%md

## Comparison with sagenb

### New Features (cloud.sagemath has these, but sagenb doesn't)

 - Project sharing with realtime synchronized editing and chat (like in Google Docs)

 - Fully de-duplicated snapshots.  This uses bup, which is an immature project, so to be really usable at scale, I'm having to work on their code a lot.

 - Better editing of files, with a split screen mode, syntax highlighting, (auto-)(un-)indent, search/replace, etc.

 - Worksheets in cloud.sagemath are at a fundamental level *much different* than in sagenb (or ipython/wakari):

    - They are a single (Codemirror) document with output in an HTML widget.  This impacts copy/paste/cursor movement/search/replace/synchronization/syntax highlighting/etc.  In theory, it will scale to very large worksheets, since codemirror stores most of the document not in DOM.

    - Syntax highlighting can be dynamically changed per cell.

    - Exactly one kind of cell, with good support for hiding input.  (Unlike Sage with two kinds of cells -- text and compute, or Ipython with a half dozen.)

 - xterm Terminal with color schemes.  Multiple clients can connect to the same terminal at once.

 - You can use your own version of Sage in each project (a binary or build from source).  Full sage development.

 - Password reset (which actually works).
︡0662b6d7-4451-4acd-a5be-644f46f5d74c︡{"html":"<h2>Comparison with sagenb</h2>\n\n<h3>New Features (cloud.sagemath has these, but sagenb doesn&#8217;t)</h3>\n\n<ul>\n<li><p>Project sharing with realtime synchronized editing and chat (like in Google Docs)</p></li>\n<li><p>Fully de-duplicated snapshots.  This uses bup, which is an immature project, so to be really usable at scale, I&#8217;m having to work on their code a lot.</p></li>\n<li><p>Better editing of files, with a split screen mode, syntax highlighting, (auto-)(un-)indent, search/replace, etc.</p></li>\n<li><p>Worksheets in cloud.sagemath are at a fundamental level <em>much different</em> than in sagenb (or ipython/wakari):</p>\n\n<ul>\n<li><p>They are a single (Codemirror) document with output in an HTML widget.  This impacts copy/paste/cursor movement/search/replace/synchronization/syntax highlighting/etc.  In theory, it will scale to very large worksheets, since codemirror stores most of the document not in DOM.</p></li>\n<li><p>Syntax highlighting can be dynamically changed per cell.</p></li>\n<li><p>Exactly one kind of cell, with good support for hiding input.  (Unlike Sage with two kinds of cells &#8211; text and compute, or Ipython with a half dozen.)</p></li>\n</ul></li>\n<li><p>xterm Terminal with color schemes.  Multiple clients can connect to the same terminal at once.</p></li>\n<li><p>You can use your own version of Sage in each project (a binary or build from source).  Full sage development.</p></li>\n<li><p>Password reset (which actually works).</p></li>\n</ul>\n"}︡
︠09cb4f7c-d0e0-4852-a721-65a401fae169︠

