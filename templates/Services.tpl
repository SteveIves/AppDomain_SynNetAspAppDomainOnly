<CODEGEN_FILENAME>Services.dbl</CODEGEN_FILENAME>
;;******************************************************************************
;;WARNING: This file was created by CodeGen. Changes will be lost if regenerated
;;******************************************************************************

import System
import System.Collections.Generic
import System.Reflection

namespace <NAMESPACE>

    ;;; <summary>
    ;;; This class exposes Synergy methods to the client application. Notice that
    ;;; it is a PARTIAL class, so additional code generated methods can be added
    ;;; to the class (for example via the ServicesCRUD template), and other
    ;;; hand-crafted methods could be added in seperate source files.
    ;;; </summary>
    public partial class Services extends MarshalByRefObject
		
        public method Services
            endparams
            record
                status, i4	;Result of XCALL SETLOG
            endrecord
        proc
            ;;CRITICAL: If your Synergy .NET code uses xfServer to access data then you must ensure that
            ;;your xfServer connection is locked to the current thread.
            try
            begin
                xcall s_server_thread_init
            end
            catch (ex)
            begin
                nop	
            end
            endtry
        endmethod

    endclass
	
endnamespace