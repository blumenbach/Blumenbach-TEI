on(dom.byId("logout"), "click", function(e) {
                e.preventDefault();
                xhr.post({
                    url: "login?logout=true",
                    load: function(data) {
                        login = null;
                        domStyle.set("login-dialog-form", "display", "block");
                        domStyle.set("login-dialog-logout", "display", "none");
                        registry.byId("user").set("label", "Not logged in");
                        popup.close(registry.byId("login-dialog"));
                        form.reset();
                    },
                    error: function(error) {
                        console.debug("error: ", error);
                        status("Logout failed");
                    }
                });
            }));
            