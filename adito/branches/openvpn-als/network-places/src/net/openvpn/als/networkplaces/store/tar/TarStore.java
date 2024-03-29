
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
			
package net.openvpn.als.networkplaces.store.tar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.openvpn.als.networkplaces.DefaultArchiveMount;
import net.openvpn.als.networkplaces.AbstractNetworkPlaceMount;
import net.openvpn.als.networkplaces.AbstractNetworkPlaceStore;
import net.openvpn.als.policyframework.LaunchSession;

public class TarStore extends AbstractNetworkPlaceStore {
    final static Log log = LogFactory.getLog(TarStore.class);
	/**
	 * Tar scheme name
	 */
	public final static String TAR_SCHEME = "tar";

    public TarStore() {
        this(TAR_SCHEME);
    }

    public TarStore(String storeName) {
        super(storeName, "UTF-8");
    }

    /* (non-Javadoc)
     * @see net.openvpn.als.vfs.AbstractNetworkPlaceStore#createMount(net.openvpn.als.policyframework.LaunchSession)
     */
    protected AbstractNetworkPlaceMount createMount(LaunchSession launchSession) throws Exception {
        return new DefaultArchiveMount(launchSession, this);
    }
}