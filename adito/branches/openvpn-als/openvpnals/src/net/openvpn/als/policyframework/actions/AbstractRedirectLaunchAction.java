
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
			
package net.openvpn.als.policyframework.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.openvpn.als.agent.DefaultAgentManager;
import net.openvpn.als.boot.Util;
import net.openvpn.als.core.CoreUtil;
import net.openvpn.als.core.actions.AuthenticatedAction;
import net.openvpn.als.policyframework.LaunchSession;
import net.openvpn.als.policyframework.LaunchSessionFactory;
import net.openvpn.als.policyframework.Policy;
import net.openvpn.als.policyframework.Resource;
import net.openvpn.als.policyframework.ResourceType;
import net.openvpn.als.security.Constants;
import net.openvpn.als.security.SessionInfo;

/**
 * Abstract implementation of {@link net.openvpn.als.core.actions.AuthenticatedAction}
 * that 'Launches' some kind of <i>Resource</i>.
 * <p>
 */
public abstract class AbstractRedirectLaunchAction extends AbstractLaunchAction {

    /**
     * Constructor. 
     * 
     * @param resourceType 
     * @param navigationContext 
     * 
     */
    public AbstractRedirectLaunchAction(ResourceType resourceType, int navigationContext) {
    	super(resourceType, navigationContext);
    }

    protected ActionForward launch(ActionMapping mapping, LaunchSession launchSession, HttpServletRequest request, String returnTo)
                    throws Exception {
        if(isDirectLink(launchSession)) {
    		String link = doPrepareLink(launchSession, returnTo);
    		return new ActionForward(link, true);
        }
        else {
        	request.setAttribute(Constants.REQ_ATTR_FORWARD_TO, returnTo);
        	request.setAttribute(Constants.REQ_ATTR_FOLDER, "");
        	request.setAttribute(Constants.REQ_ATTR_TARGET, "");
        	request.setAttribute(Constants.REQ_ATTR_EXEC_ON_LOAD, doPrepareLink(launchSession, returnTo));
        	return mapping.findForward("redirect");
        }
    	
    }

    protected abstract String doPrepareLink(LaunchSession launchSession, String returnTo);

    protected abstract boolean isDirectLink(LaunchSession launchSession);
}
