(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using CognitiveSearchApp
const UserApp = CognitiveSearchApp
CognitiveSearchApp.main()
