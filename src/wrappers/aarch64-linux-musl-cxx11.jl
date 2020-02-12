# Autogenerated wrapper script for liblsl_jll for aarch64-linux-musl-cxx11
export lslver, liblsl

## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `lslver`
const lslver_splitpath = ["bin", "lslver"]

# This will be filled out by __init__() for all products, as it must be done at runtime
lslver_path = ""

# lslver-specific global declaration
function lslver(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', ENV[LIBPATH_env])
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(lslver_path)
    end
end


# Relative path to `liblsl`
const liblsl_splitpath = ["lib", "liblsl.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
liblsl_path = ""

# liblsl-specific global declaration
# This will be filled out by __init__()
liblsl_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const liblsl = "liblsl.so.1.13.0"


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"liblsl")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # We first need to add to LIBPATH_list the libraries provided by Julia
    append!(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)])
    global lslver_path = normpath(joinpath(artifact_dir, lslver_splitpath...))

    push!(PATH_list, dirname(lslver_path))
    global liblsl_path = normpath(joinpath(artifact_dir, liblsl_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global liblsl_handle = dlopen(liblsl_path)
    push!(LIBPATH_list, dirname(liblsl_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

