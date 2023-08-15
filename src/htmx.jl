module htmx
using Mux, HTTP, AssetRegistry

homepage = AssetRegistry.register("./src/index.html")

println(homepage)


@app htmx_example = (
    # Mux.prod_defaults,
    Mux.defaults,
    page(respond(homepage)),
    page("/clicked", respond("<p>You clicked the button!</p>")),
    Mux.notfound())

wait(serve(htmx_example))


end # htmx
