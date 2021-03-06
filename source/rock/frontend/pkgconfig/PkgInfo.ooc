import structs/[ArrayList, List]
import text/StringTokenizer

/**
 * Information about a package managed by pkg-config
 * @author nddrylliog aka Amos Wenger
 */
PkgInfo: class {

    /** The name of the package, e.g. gtk+-2.0, or imlib2 */
    name: String
	
    /** The output of `pkg-config --libs name` */
    libsString: String
	
    /** The output of `pkg-config --cflags name` */
    cflagsString: String
	
    /** The C flags (including the include paths) */
    cflags := ArrayList<String> new()
	
    /** A list of all libraries needed */
    libraries := ArrayList<String> new()
	
    /** A list of all include paths */
    includePaths := ArrayList<String> new()

    /** A list of all library paths */
    libPaths := ArrayList<String> new()
	
    /**
     * Create a new Package info
     */
    init: func (=name, =libsString, =cflagsString) {
        extractTokens("-L", libsString, libPaths)
        extractTokens("-l", libsString, libraries)
        "For %s, collected libraries: %s" printfln(name, libraries join(", "))
        extractTokens("-I", cflagsString, includePaths)
        extractTokens("", cflagsString, cflags)
    }

    extractTokens: func (prefix, string: String, list: List<String>) {
        prefixLength := prefix length()
            
        for(token in StringTokenizer new(string, ' ')) {
            if(token startsWith?(prefix)) {
                add := token substring(prefixLength) trim()
                if(!add empty?()) list add(add)
            }
        }
            
    }
	
}
