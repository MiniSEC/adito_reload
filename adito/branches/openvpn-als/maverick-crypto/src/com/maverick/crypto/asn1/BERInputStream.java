
				/*
 *  OpenVPNALS
 *
 *  Copyright (C) 2003-2006 3SP LTD. All Rights Reserved
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2 of
 *  the License, or (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public
 *  License along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
			
package com.maverick.crypto.asn1;

import java.io.ByteArrayOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Vector;

public class BERInputStream
    extends DERInputStream
{
	private DERObject END_OF_STREAM = new DERObject() {
										void encode(
											DEROutputStream out)
										throws IOException
										{
											throw new IOException("Eeek!");
										}

									};
    public BERInputStream(
        InputStream is)
    {
        super(is);
    }

    /**
     * read a string of bytes representing an indefinite length object.
     */
    private byte[] readIndefiniteLengthFully()
        throws IOException
    {
        ByteArrayOutputStream   bOut = new ByteArrayOutputStream();
        int                     b, b1;

        b1 = read();

        while ((b = read()) >= 0)
        {
			if (b1 == 0 && b == 0)
			{
				break;
			}

            bOut.write(b1);
            b1 = b;
        }

        return bOut.toByteArray();
    }

	private BERConstructedOctetString buildConstructedOctetString()
		throws IOException
	{
        Vector                  octs = new Vector();

		for (;;)
		{
			DERObject		o = readObject();

			if (o == END_OF_STREAM)
			{
				break;
			}

            octs.addElement(o);
		}

		return new BERConstructedOctetString(octs);
	}

    public DERObject readObject()
        throws IOException
    {
        int tag = read();
        if (tag == -1)
        {
            throw new EOFException();
        }

        int     length = readLength();

        if (length < 0)    // indefinite length method
        {
            switch (tag)
            {
            case NULL:
                return null;
            case SEQUENCE | CONSTRUCTED:
                BERConstructedSequence  seq = new BERConstructedSequence();

				for (;;)
				{
					DERObject   obj = readObject();

					if (obj == END_OF_STREAM)
					{
						break;
					}

					seq.addObject(obj);
				}
				return seq;
            case OCTET_STRING | CONSTRUCTED:
				return buildConstructedOctetString();
            case SET | CONSTRUCTED:
                ASN1EncodableVector  v = new ASN1EncodableVector();

				for (;;)
				{
					DERObject   obj = readObject();

					if (obj == END_OF_STREAM)
					{
						break;
					}

					v.add(obj);
				}
				return new BERSet(v);
            default:
                //
                // with tagged object tag number is bottom 5 bits
                //
                if ((tag & TAGGED) != 0)
                {
                    if ((tag & 0x1f) == 0x1f)
                    {
                        throw new IOException("unsupported high tag encountered");
                    }

                    //
                    // simple type - implicit... return an octet string
                    //
                    if ((tag & CONSTRUCTED) == 0)
                    {
                        byte[]  bytes = readIndefiniteLengthFully();

                        return new BERTaggedObject(false, tag & 0x1f, new DEROctetString(bytes));
                    }

                    //
                    // either constructed or explicitly tagged
                    //
					DERObject		dObj = readObject();

					if (dObj == END_OF_STREAM)     // empty tag!
                    {
                        return new DERTaggedObject(tag & 0x1f);
                    }

                    DERObject       next = readObject();

                    //
                    // explicitly tagged (probably!) - if it isn't we'd have to
                    // tell from the context
                    //
                    if (next == END_OF_STREAM)
                    {
                        return new BERTaggedObject(tag & 0x1f, dObj);
                    }

                    //
                    // another implicit object, we'll create a sequence...
                    //
                    seq = new BERConstructedSequence();

                    seq.addObject(dObj);

                    do
                    {
                        seq.addObject(next);
                        next = readObject();
                    }
                    while (next != END_OF_STREAM);

                    return new BERTaggedObject(false, tag & 0x1f, seq);
                }

                throw new IOException("unknown BER object encountered");
            }
        }
        else
        {
            if (tag == 0 && length == 0)    // end of contents marker.
            {
                return END_OF_STREAM;
            }

            byte[]  bytes = new byte[length];

            readFully(bytes);

			return buildObject(tag, bytes);
        }
    }
}
