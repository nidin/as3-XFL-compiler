package nid.xfl.compiler.abc 
{
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class AbcFactory 
	{
		
		public function AbcFactory() 
		{
		}
		static public function opcode(_abc:String):int
		{
			switch(_abc)
			{
				case 'add': return 0xA0; break;
				case 'add_i': return 0xC5; break;
				case 'astype': return 0x86; break;
				case 'astypelate': return 0x87; break;
				case 'bitand': return 0xA8; break;
				case 'bitnot': return 0x97; break;
				case 'bitor': return 0xA9; break;
				case 'bitxor': return 0xAA; break;
				case 'bkpt': return 0x01; break;
				case 'bkptline': return 0xF2; break;
				case 'call': return 0x41; break;
				case 'callmethod': return 0x43; break;
				case 'callproperty': return 0x46; break;
				case 'callproplex': return 0x4C; break;
				case 'callpropvoid': return 0x4F; break;
				case 'callstatic': return 0x44; break;
				case 'callsuper': return 0x45; break;
				case 'callsupervoid': return 0x4E; break;
				case 'checkfilter': return 0x78; break;
				case 'coerce': return 0x80; break;
				case 'coerce_a': return 0x82; break;
				case 'coerce_b': return 0x81; break;
				case 'coerce_d': return 0x84; break;
				case 'coerce_i': return 0x83; break;
				case 'coerce_o': return 0x89; break;
				case 'coerce_s': return 0x85; break;
				case 'coerce_u': return 0x88; break;
				case 'construct': return 0x42; break;
				case 'constructprop': return 0x4A; break;
				case 'constructsuper': return 0x49; break;
				case 'convert_b': return 0x76; break;
				case 'convert_d': return 0x75; break;
				case 'convert_i': return 0x73; break;
				case 'convert_o': return 0x77; break;
				case 'convert_s': return 0x70; break;
				case 'convert_u': return 0x74; break;
				case 'debug': return 0xEF; break;
				case 'debugfile': return 0xF1; break;
				case 'debugline': return 0xF0; break;
				case 'declocal': return 0x94; break;
				case 'declocal_i': return 0xC3; break;
				case 'decrement': return 0x93; break;
				case 'decrement_i': return 0xC1; break;
				case 'deleteproperty': return 0x6A; break;
				case 'divide': return 0xA3; break;
				case 'dup': return 0x2A; break;
				case 'dxns': return 0x06; break;
				case 'dxnslate': return 0x07; break;
				case 'equals': return 0xAB; break;
				case 'esc_xattr': return 0x72; break;
				case 'esc_xelem': return 0x71; break;
				case 'finddef': return 0x5F; break;
				case 'findproperty': return 0x5E; break;
				case 'findpropstrict': return 0x5D; break;
				case 'getdescendants': return 0x59; break;
				case 'getglobalscope': return 0x64; break;
				case 'getglobalslot': return 0x6E; break;
				case 'getlex': return 0x60; break;
				case 'getlocal': return 0x62; break;
				case 'getlocal0': return 0xD0; break;
				case 'getlocal1': return 0xD1; break;
				case 'getlocal2': return 0xD2; break;
				case 'getlocal3': return 0xD3; break;
				case 'getproperty': return 0x66; break;
				case 'getscopeobject': return 0x65; break;
				case 'getslot': return 0x6C; break;
				case 'getsuper': return 0x04; break;
				case 'greaterequals': return 0xB0; break;
				case 'greaterthan': return 0xAF; break;
				case 'hasnext': return 0x1F; break;
				case 'hasnext2': return 0x32; break;
				case 'ifeq': return 0x13; break;
				case 'iffalse': return 0x12; break;
				case 'ifge': return 0x18; break;
				case 'ifgt': return 0x17; break;
				case 'ifle': return 0x16; break;
				case 'iflt': return 0x15; break;
				case 'ifne': return 0x14; break;
				case 'ifnge': return 0x0F; break;
				case 'ifngt': return 0x0E; break;
				case 'ifnle': return 0x0D; break;
				case 'ifnlt': return 0x0C; break;
				case 'ifstricteq': return 0x19; break;
				case 'ifstrictne': return 0x1A; break;
				case 'iftrue': return 0x11; break;
				case 'in': return 0xB4; break;
				case 'inclocal': return 0x92; break;
				case 'inclocal_i': return 0xC2; break;
				case 'increment': return 0x91; break;
				case 'increment_i': return 0xC0; break;
				case 'initproperty': return 0x68; break;
				case 'instanceof': return 0xB1; break;
				case 'istype': return 0xB2; break;
				case 'istypelate': return 0xB3; break;
				case 'jump': return 0x10; break;
				case 'kill': return 0x08; break;
				case 'label': return 0x09; break;
				case 'lessequals': return 0xAE; break;
				case 'lessthan': return 0xAD; break;
				case 'lookupswitch': return 0x1B; break;
				case 'lshift': return 0xA5; break;
				case 'modulo': return 0xA4; break;
				case 'multiply': return 0xA2; break;
				case 'multiply_i': return 0xC7; break;
				case 'negate': return 0x90; break;
				case 'negate_i': return 0xC4; break;
				case 'newactivation': return 0x57; break;
				case 'newarray': return 0x56; break;
				case 'newcatch': return 0x5A; break;
				case 'newclass': return 0x58; break;
				case 'newfunction': return 0x40; break;
				case 'newobject': return 0x55; break;
				case 'nextname': return 0x1E; break;
				case 'nextvalue': return 0x23; break;
				case 'nop': return 0x02; break;
				case 'not': return 0x96; break;
				case 'pop': return 0x29; break;
				case 'popscope': return 0x1D; break;
				case 'pushbyte': return 0x24; break;
				case 'pushdouble': return 0x2F; break;
				case 'pushfalse': return 0x27; break;
				case 'pushint': return 0x2D; break;
				case 'pushnamespace': return 0x31; break;
				case 'pushnan': return 0x28; break;
				case 'pushnull': return 0x20; break;
				case 'pushscope': return 0x30; break;
				case 'pushshort': return 0x25; break;
				case 'pushstring': return 0x2C; break;
				case 'pushtrue': return 0x26; break;
				case 'pushuint': return 0x2E; break;
				case 'pushundefined': return 0x21; break;
				case 'pushwith': return 0x1C; break;
				case 'returnvalue': return 0x48; break;
				case 'returnvoid': return 0x47; break;
				case 'rshift': return 0xA6; break;
				case 'setglobalslot': return 0x6F; break;
				case 'setlocal': return 0x63; break;
				case 'setlocal0': return 0xD4; break;
				case 'setlocal1': return 0xD5; break;
				case 'setlocal2': return 0xD6; break;
				case 'setlocal3': return 0xD7; break;
				case 'setproperty': return 0x61; break;
				case 'setslot': return 0x6D; break;
				case 'setsuper': return 0x05; break;
				case 'strictequals': return 0xAC; break;
				case 'subtract': return 0xA1; break;
				case 'subtract_i': return 0xC6; break;
				case 'swap': return 0x2B; break;
				case 'throw': return 0x03; break;
				case 'timestamp': return 0xF3; break;
				case 'typeof': return 0x95; break;
				case 'urshift': return 0xA7; break;
				default :return 0x02; break;//nop
				
			}
			
		}
		static public function abc(_opcode:int):String
		{
			switch(_opcode)
			{
				case 0xA0: return 'add'; break;
				case 0xC5: return 'add_i'; break;
				case 0x86: return 'astype'; break;
				case 0x87: return 'astypelate'; break;
				case 0xA8: return 'bitand'; break;
				case 0x97: return 'bitnot'; break;
				case 0xA9: return 'bitor'; break;
				case 0xAA: return 'bitxor'; break;
				case 0x01: return 'bkpt'; break;
				case 0xF2: return 'bkptline'; break;
				case 0x41: return 'call'; break;
				case 0x43: return 'callmethod'; break;
				case 0x46: return 'callproperty'; break;
				case 0x4C: return 'callproplex'; break;
				case 0x4F: return 'callpropvoid'; break;
				case 0x44: return 'callstatic'; break;
				case 0x45: return 'callsuper'; break;
				case 0x4E: return 'callsupervoid'; break;
				case 0x78: return 'checkfilter'; break;
				case 0x80: return 'coerce'; break;
				case 0x82: return 'coerce_a'; break;
				case 0x81: return 'coerce_b'; break;
				case 0x84: return 'coerce_d'; break;
				case 0x83: return 'coerce_i'; break;
				case 0x89: return 'coerce_o'; break;
				case 0x85: return 'coerce_s'; break;
				case 0x88: return 'coerce_u'; break;
				case 0x42: return 'construct'; break;
				case 0x4A: return 'constructprop'; break;
				case 0x49: return 'constructsuper'; break;
				case 0x76: return 'convert_b'; break;
				case 0x75: return 'convert_d'; break;
				case 0x73: return 'convert_i'; break;
				case 0x77: return 'convert_o'; break;
				case 0x70: return 'convert_s'; break;
				case 0x74: return 'convert_u'; break;
				case 0xEF: return 'debug'; break;
				case 0xF1: return 'debugfile'; break;
				case 0xF0: return 'debugline'; break;
				case 0x94: return 'declocal'; break;
				case 0xC3: return 'declocal_i'; break;
				case 0x93: return 'decrement'; break;
				case 0xC1: return 'decrement_i'; break;
				case 0x6A: return 'deleteproperty'; break;
				case 0xA3: return 'divide'; break;
				case 0x2A: return 'dup'; break;
				case 0x06: return 'dxns'; break;
				case 0x07: return 'dxnslate'; break;
				case 0xAB: return 'equals'; break;
				case 0x72: return 'esc_xattr'; break;
				case 0x71: return 'esc_xelem'; break;
				case 0x5F: return 'finddef'; break;
				case 0x5E: return 'findproperty'; break;
				case 0x5D: return 'findpropstrict'; break;
				case 0x59: return 'getdescendants'; break;
				case 0x64: return 'getglobalscope'; break;
				case 0x6E: return 'getglobalslot'; break;
				case 0x60: return 'getlex'; break;
				case 0x62: return 'getlocal'; break;
				case 0xD0: return 'getlocal0'; break;
				case 0xD1: return 'getlocal1'; break;
				case 0xD2: return 'getlocal2'; break;
				case 0xD3: return 'getlocal3'; break;
				case 0x66: return 'getproperty'; break;
				case 0x65: return 'getscopeobject'; break;
				case 0x6C: return 'getslot'; break;
				case 0x04: return 'getsuper'; break;
				case 0xB0: return 'greaterequals'; break;
				case 0xAF: return 'greaterthan'; break;
				case 0x1F: return 'hasnext'; break;
				case 0x32: return 'hasnext2'; break;
				case 0x13: return 'ifeq'; break;
				case 0x12: return 'iffalse'; break;
				case 0x18: return 'ifge'; break;
				case 0x17: return 'ifgt'; break;
				case 0x16: return 'ifle'; break;
				case 0x15: return 'iflt'; break;
				case 0x14: return 'ifne'; break;
				case 0x0F: return 'ifnge'; break;
				case 0x0E: return 'ifngt'; break;
				case 0x0D: return 'ifnle'; break;
				case 0x0C: return 'ifnlt'; break;
				case 0x19: return 'ifstricteq'; break;
				case 0x1A: return 'ifstrictne'; break;
				case 0x11: return 'iftrue'; break;
				case 0xB4: return 'in'; break;
				case 0x92: return 'inclocal'; break;
				case 0xC2: return 'inclocal_i'; break;
				case 0x91: return 'increment'; break;
				case 0xC0: return 'increment_i'; break;
				case 0x68: return 'initproperty'; break;
				case 0xB1: return 'instanceof'; break;
				case 0xB2: return 'istype'; break;
				case 0xB3: return 'istypelate'; break;
				case 0x10: return 'jump'; break;
				case 0x08: return 'kill'; break;
				case 0x09: return 'label'; break;
				case 0xAE: return 'lessequals'; break;
				case 0xAD: return 'lessthan'; break;
				case 0x1B: return 'lookupswitch'; break;
				case 0xA5: return 'lshift'; break;
				case 0xA4: return 'modulo'; break;
				case 0xA2: return 'multiply'; break;
				case 0xC7: return 'multiply_i'; break;
				case 0x90: return 'negate'; break;
				case 0xC4: return 'negate_i'; break;
				case 0x57: return 'newactivation'; break;
				case 0x56: return 'newarray'; break;
				case 0x5A: return 'newcatch'; break;
				case 0x58: return 'newclass'; break;
				case 0x40: return 'newfunction'; break;
				case 0x55: return 'newobject'; break;
				case 0x1E: return 'nextname'; break;
				case 0x23: return 'nextvalue'; break;
				case 0x02: return 'nop'; break;
				case 0x96: return 'not'; break;
				case 0x29: return 'pop'; break;
				case 0x1D: return 'popscope'; break;
				case 0x24: return 'pushbyte'; break;
				case 0x2F: return 'pushdouble'; break;
				case 0x27: return 'pushfalse'; break;
				case 0x2D: return 'pushint'; break;
				case 0x31: return 'pushnamespace'; break;
				case 0x28: return 'pushnan'; break;
				case 0x20: return 'pushnull'; break;
				case 0x30: return 'pushscope'; break;
				case 0x25: return 'pushshort'; break;
				case 0x2C: return 'pushstring'; break;
				case 0x26: return 'pushtrue'; break;
				case 0x2E: return 'pushuint'; break;
				case 0x21: return 'pushundefined'; break;
				case 0x1C: return 'pushwith'; break;
				case 0x48: return 'returnvalue'; break;
				case 0x47: return 'returnvoid'; break;
				case 0xA6: return 'rshift'; break;
				case 0x6F: return 'setglobalslot'; break;
				case 0x63: return 'setlocal'; break;
				case 0xD4: return 'setlocal0'; break;
				case 0xD5: return 'setlocal1'; break;
				case 0xD6: return 'setlocal2'; break;
				case 0xD7: return 'setlocal3'; break;
				case 0x61: return 'setproperty'; break;
				case 0x6D: return 'setslot'; break;
				case 0x05: return 'setsuper'; break;
				case 0xAC: return 'strictequals'; break;
				case 0xA1: return 'subtract'; break;
				case 0xC6: return 'subtract_i'; break;
				case 0x2B: return 'swap'; break;
				case 0x03: return 'throw'; break;
				case 0xF3: return 'timestamp'; break;
				case 0x95: return 'typeof'; break;
				case 0xA7: return 'urshift'; break;
				default :return 'Unknow opcode!'; break;
				
			}
			
		}
		
	}

}