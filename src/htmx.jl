module htmx
using HTTP, AssetRegistry, Toolips
# using Mux

homepage = AssetRegistry.register("./src/index.html")

println(homepage)
# http://assetserver/6ef0b93ebfd67d42b43c8059b970b270651aab35-index.html

# @app htmx_example = (
#     # Mux.prod_defaults,  	# production defaults for Mux
#     Mux.defaults,    # dev defaults for Mux
#     page("/", respond(
#         http:///assetserver/6ef0b93ebfd67d42b43c8059b970b270651aab35-index.html
#     )),
#     page("/clicked", respond("<p>You clicked the button!</p>")),
#     Mux.notfound()
# )

# wait(serve(htmx_example))

# function handler(req)
#     return HTTP.response(homepage)
# end


# HTTP.serve(handler, ip"0.0.0.0", port=3000)



# Toolips

html = """<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>HTMX + Julia</title>
</head>
<body>
	<!-- have a button POST a click via AJAX -->
	<button hx-post="/clicked" hx-swap="outerHTML">
	  Click Me
	</button>

	<script src="https://unpkg.com/htmx.org@1.9.4"></script>
</body>
</html>
"""

home = Toolips.route("/") do c::Connection
    write!(c, html)
end

clicked = Toolips.route("/clicked") do c::Connection
    write!(c, "<p>You clicked the button! HTMX works!</p>")
end

server = WebServer(routes=[home, clicked])
server.start()

end # htmx
