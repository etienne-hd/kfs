/* posix.vapi
 *
 * Copyright (C) 2008-2009  Jürg Billeter
 * Copyright (C) 2010 Marco Trevisan (Treviño)
 * Copyright (C) 2013 Nikolay Orliuk
 * Copyright (C) 2020-2025 Reuben Thomas
 * Copyright (C) 2021 Nikola Hadžić
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 *  Marco Trevisan (Treviño) <mail@3v1n0.net>
 *  Nikolay Orliuk <virkony@gmail.com>
 *  Nikola Hadžić <nikola.hadzic.000@protonmail.com>
 */

#if POSIX
[CCode (cname = "bool", cheader_filename = "stdbool.h", default_value = "false")]
[BooleanType]
public struct bool {
	public inline unowned string to_string () {
		if (this) {
			return "true";
		} else {
			return "false";
		}
	}

	public static inline bool parse (string str) {
		if (str == "true") {
			return true;
		} else {
			return false;
		}
	}
}

[CCode (cname = "char", default_value = "\'\\0\'")]
[IntegerType (rank = 2, min = 0, max = 127)]
public struct char {
	public inline string to_string () {
		return "%c".printf (this);
	}
}

[CCode (cname = "unsigned char", default_value = "\'\\0\'")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uchar {
	public inline string to_string () {
		return "%hhu".printf (this);
	}
}

[CCode (cname = "int", default_value = "0")]
[IntegerType (rank = 6)]
public struct int {
	public inline string to_string () {
		return "%d".printf (this);
	}
}

[CCode (cname = "unsigned int", default_value = "0U")]
[IntegerType (rank = 7)]
public struct uint {
	public inline string to_string () {
		return "%u".printf (this);
	}
}

[CCode (cname = "short", default_value = "0")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct short {
	public inline string to_string () {
		return "%hi".printf (this);
	}
}

[CCode (cname = "unsigned short", default_value = "0U")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct ushort {
	public inline string to_string () {
		return "%hu".printf (this);
	}
}

[CCode (cname = "long", default_value = "0L")]
[IntegerType (rank = 8)]
public struct long {
	public inline string to_string () {
		return "%li".printf (this);
	}
}

[CCode (cname = "unsigned long", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct ulong {
	public inline string to_string () {
		return "%lu".printf (this);
	}
}

[CCode (cname = "size_t", cheader_filename = "stddef.h", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct size_t {
	public inline string to_string () {
		return "%zu".printf (this);
	}
}

[CCode (cname = "ssize_t", cheader_filename = "stddef.h", default_value = "0L")]
[IntegerType (rank = 8)]
public struct ssize_t {
	public inline string to_string () {
		return "%zi".printf (this);
	}
}

[CCode (cname = "int8_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 1, min = -128, max = 127)]
public struct int8 {
}

[CCode (cname = "uint8_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uint8 {
}

[CCode (cname = "int16_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct int16 {
	[CCode (cname = "PRIi16", cheader_filename = "inttypes.h")]
	public const string FORMAT;

	public inline string to_string () {
		return ("%" + FORMAT).printf (this);
	}
}

[CCode (cname = "uint16_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct uint16 {
}

[CCode (cname = "int32_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 6)]
public struct int32 {
}

[CCode (cname = "uint32_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 7)]
public struct uint32 {
}

[CCode (cname = "int64_t", cheader_filename = "stdint.h", default_value = "0LL")]
[IntegerType (rank = 10)]
public struct int64 {
}

[CCode (cname = "uint64_t", cheader_filename = "stdint.h", default_value = "0ULL")]
[IntegerType (rank = 11)]
public struct uint64 {
}

[CCode (cname = "float", default_value = "0.0F")]
[FloatingType (rank = 1)]
public struct float {
}

[CCode (cname = "double", default_value = "0.0")]
[FloatingType (rank = 2)]
public struct double {
}

[CCode (cheader_filename = "time.h")]
[IntegerType (rank = 8)]
public struct time_t {
	[CCode (cname = "time")]
	public time_t (time_t? tloc = null);
}

[SimpleType]
[CCode (cheader_filename = "stdarg.h", cprefix = "va_", has_type_id = false, destroy_function = "va_end", lvalue_access = false)]
public struct va_list {
	[CCode (cname = "va_start")]
	public va_list ();
	[CCode (cname = "va_copy")]
	public va_list.copy (va_list src);
	[CCode (generic_type_pos = 1.1, simple_generics = true)]
	public unowned G arg<G> ();
}

[Compact]
[Immutable]
[CCode (cname = "char", const_cname = "const char", free_function = "free", cheader_filename = "libft.h")]
public class string {
	[PrintfFormat]
	public string printf (...);

	public string concat (...) {
		string result = this;
		var l = va_list ();
		while (true) {
			unowned string? arg = l.arg ();
			if (arg == null) {
				break;
			} else {
				result += arg;
			}
		}
		return result;
	}

    [CCode (cname="strcmp")]
    public void compare(string cmp);

	[CCode (cname="strstr")]
    public bool contains(string cmp);

	public inline unowned string to_string () {
		return this;
	}


    public char get(int index) {
        char *self = (char*)this;
        return self[index]; 
    }

	public int size {
		[CCode (cname = "ft_strlen")]
		get;
	}
}

// [CCode (cname="printf", cheader_filename = "stdio.h")]
// [PrintfFormat]
// public void print (string format,...);

#endif

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Posix {
	[CCode (cheader_filename = "assert.h")]
	public void assert (bool expression);


}
