# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule liblsl_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("liblsl")
JLLWrappers.@generate_main_file("liblsl", Base.UUID("b37880e1-55fa-5503-9f1a-f1223ce0b53e"))
end  # module liblsl_jll
