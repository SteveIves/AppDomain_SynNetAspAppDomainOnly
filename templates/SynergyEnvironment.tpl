<CODEGEN_FILENAME>SynergyEnvironment.dbl</CODEGEN_FILENAME>
;;******************************************************************************
;;WARNING: This file was created by CodeGen. Changes will be lost if regenerated
;;******************************************************************************

import System
import System.Collections.Generic
import System.Reflection

namespace <NAMESPACE>

	public class SynergyEnvironment

		public static environmentSet, boolean, false

		public static method SetEnvironment, void
			required in settings, @Dictionary<String, String>
			endparams
		proc
			if (!environmentSet)
			begin
				data item, @KeyValuePair<String,String>
				data status, i4
				foreach item in settings
					xcall setlog(item.Key, item.Value, status)
				environmentSet = true
			end
		endmethod
	
	endclass

endnamespace
