# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# "Actor",
        # "Stunt Double",
        # "Voice",
        # "Cameo",
        # "Special Guest"
cast_roles = CastRole.create([{role: 'Screenplay'},
                        {role: 'Author'},
                        {role: 'Novel'},
                        {role: 'Writer'},
                        {role: 'Other'},
                        {role: 'Original Story'},
                        {role: 'Story Editor'},
                        {role: 'Story'},
                        {role: 'Director'},
                        {role: 'Co-Director'},
                        {role: 'Assistant Director'},
                        {role: 'Script Coordinator'},
                        {role: 'Actor'},
                        {role: 'Voice'},
                        {role: 'Cameo'},
                        {role: 'Special Guest'},
                        {role: 'Director of Photography'},
                        {role: 'Editor'},
                        {role: 'Production Design'},
                        {role: 'Art Direction'},
                        {role: 'Costume Design'},
                        {role: 'Makeup Artist'},
                        {role: 'Producer'},
                        {role: 'Executive Producer'},
                        {role: 'Casting'},
                        {role: 'Original Music Composer'},
                        {role: 'Animation'},
                        {role: 'Visual Effects'},
                        {role: 'Special Effects'}
                        ])