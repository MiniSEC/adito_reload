
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
			
package net.openvpn.als.applications.wizards.forms;

import net.openvpn.als.applications.ApplicationsPlugin;
import net.openvpn.als.policyframework.forms.AbstractWizardResourcePolicySelectionForm;

/**
 * Implementation of a {@link net.openvpn.als.policyframework.forms.AbstractWizardResourcePolicySelectionForm}
 * that allows an administrator to assign policies to new <i>Application Shortcuts</i>.
 */
public class ApplicationShortcutWizardPolicySelectionForm extends AbstractWizardResourcePolicySelectionForm {

    /**
     * Constructor
     */
    public ApplicationShortcutWizardPolicySelectionForm() {
        super(true, true, "/WEB-INF/jsp/content/applications/applicationShortcutWizard/" +
                "applicationPolicySelection.jspf", 
                        "applicationShortcutPolicySelection", ApplicationsPlugin.MESSAGE_RESOURCES_KEY, "applicationShortcutWizard.applicationShortcutPolicySelection", 4, ApplicationsPlugin.APPLICATION_SHORTCUT_RESOURCE_TYPE);
    }
}
