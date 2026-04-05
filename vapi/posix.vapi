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
	[CCode (cname = "isalnum")]
	public char is_alnum ();
	[CCode (cname = "isalpha")]
	public char is_alpha ();
	[CCode (cname = "isascii")]
	public char is_ascii ();
	[CCode (cname = "isdigit")]
	public char is_digit ();
	[CCode (cname = "isprint")]
	public char is_print ();
	[CCode (cname = "isspace")]
	public char is_space ();
	[CCode (cname = "tolower")]
	public char to_lower ();
	[CCode (cname = "toupper")]
	public char to_upper ();
}

[CCode (cname = "unsigned char", default_value = "\'\\0\'")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uchar {
	[CCode (cname = "isalnum")]
	public uchar is_alnum ();
	[CCode (cname = "isalpha")]
	public uchar is_alpha ();
	[CCode (cname = "isascii")]
	public uchar is_ascii ();
	[CCode (cname = "isdigit")]
	public uchar is_digit ();
	[CCode (cname = "isprint")]
	public uchar is_print ();
	[CCode (cname = "isspace")]
	public uchar is_space ();
	[CCode (cname = "tolower")]
	public uchar to_lower ();
	[CCode (cname = "toupper")]
	public uchar to_upper ();
}

[CCode (cname = "int", default_value = "0")]
[IntegerType (rank = 6)]
public struct int {
}

[CCode (cname = "unsigned int", default_value = "0U")]
[IntegerType (rank = 7)]
public struct uint {
}

[CCode (cname = "short", default_value = "0")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct short {
}

[CCode (cname = "unsigned short", default_value = "0U")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct ushort {
}

[CCode (cname = "long", default_value = "0L")]
[IntegerType (rank = 8)]
public struct long {
}

[CCode (cname = "unsigned long", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct ulong {
}

[CCode (cname = "size_t", cheader_filename = "stddef.h", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct size_t {
}

[CCode (cname = "ssize_t", cheader_filename = "stddef.h", default_value = "0L")]
[IntegerType (rank = 8)]
public struct ssize_t {
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

[CCode (cname = "uintptr_t", cheader_filename = "stdint.h")]
public struct uintptr : size_t {

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
	// [PrintfFormat]
	// public string printf (...);

	// public string concat (...) {
		// string result = this;
		// var l = va_list ();
		// while (true) {
			// unowned string? arg = l.arg ();
			// if (arg == null) {
				// break;
			// } else {
				// result += arg;
			// }
		// }
		// return result;
	// }

    [CCode (cname="vala_string_has_prefix")]
	public bool has_prefix (string prefix) {
		return strncmp (this, prefix, prefix.size) == 0;
	}

	[CCode (cname="vala_string_has_suffix")]
	public bool has_suffix (string suffix) {
		char* self = (char*)this;
		return strncmp (self + size - suffix.size, suffix, suffix.size) == 0;
	}

	[CCode (cname="vala_string_index_of")]
	public int index_of (string needle) {
		char* self = (char*)this;
		char* found = strstr (self, needle);
		if (found == null) {
			return -1;
		} else {
			return (int) (found - self);
		}
	}

    [CCode (cname="vala_string_compare")]
    public bool compare (string cmp) {
		return strcmp (this, cmp) == 0;
	}

	[CCode (cname="vala_string_contains")]
	public bool contains (string cmp) {
		return strstr (this, cmp) != null;
	}

	[CCode (cname="vala_string_to_string")]
	public inline unowned string to_string () {
		return this;
	}

	[CCode (cname="vala_string_get")]
    public char get(int index) {
        char *self = (char*)this;
        return self[index]; 
    }

	public int size {
		[CCode (cname = "strlen")]
		get;
	}
}

[CCode (cname="strncmp")]
public static int strncmp(char *s1, char *s2, size_t n);
[CCode (cname="strchr")]
public static char *strchr(char *s, int c);
[CCode (cname="strstr")]
public static char *strstr(char *haystack, char *needle);
[CCode (cname="strcmp")]
public static int strcmp(char *s1, char *s2);
[CCode (cname="atoi")]
public static int atoi(char *str);
[CCode (cname="strcat")]
public static char *strcat(char *dest, char *src);
[CCode (cname="strcpy")]
public static char *strcpy(char *dest, char *src);
// [CCode (cname="printf", cheader_filename = "stdio.h")]
// [PrintfFormat]
// public void print (string format,...);

#endif

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Posix {
	[CCode (cheader_filename = "assert.h")]
	public void assert (bool expression);

	namespace Memory {
		[CCode (cname = "memmove")]
		public void *move(void* dest, void* src, size_t n);
		[CCode (cname = "memcmp")]
		public int	cmp(void *s1, void *s2, size_t n);
		[CCode (cname = "memchr")]
		public void* chr(void* mem, int byte, size_t n);
		[CCode (cname = "memset")]
		public void* set(void *s, int c, size_t n);
		[CCode (cname = "memsetw")]
		public void* setword(void *s, uint16 c, size_t elem);
		[CCode (cname = "memcpy")]
		public void *cpy(void *dest, void *src, size_t n);
		[CCode (cname = "bzero")]
		public void bzero(void *s, size_t n);
	}

}
