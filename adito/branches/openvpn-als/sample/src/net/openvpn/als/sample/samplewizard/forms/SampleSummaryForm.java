
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
			
package net.openvpn.als.sample.samplewizard.forms;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.openvpn.als.boot.PropertyList;
import net.openvpn.als.core.CoreServlet;
import net.openvpn.als.sample.samplewizard.actions.SampleDetailsAction;
import net.openvpn.als.security.User;
import net.openvpn.als.wizard.AbstractWizardSequence;
import net.openvpn.als.wizard.forms.DefaultWizardForm;

/**
 * <p>
 * The form for the resource summary.
 * 
 * @author James D Robinson <a href="mailto:james@localhost">&lt;james@localhost&gt;</a>
 * 
 */
public class SampleSummaryForm extends DefaultWizardForm {

    final static Log log = LogFactory.getLog(SampleSummaryForm.class);

    private User user;
    private String resourceName;
    private List selectedPolicies;

    /**
     * Constructor
     */
    public SampleSummaryForm() {
        super(false, true, "/WEB-INF/jsp/content/sample/samplewizard/sampleSummary.jspf", "", true, true, "sampleSummary",
                        "sample", "samplewizard.sampleSummary", 4);
    }

    /*
     * (non-Javadoc)
     * 
     * @see net.openvpn.als.wizard.forms.AbstractWizardForm#init(net.openvpn.als.wizard.AbstractWizardSequence)
     */
    public void init(AbstractWizardSequence sequence, HttpServletRequest request) throws Exception {
        resourceName = (String) sequence.getAttribute(SampleDefaultDetailsForm.ATTR_RESOURCE_NAME, null);
        PropertyList l = (PropertyList) sequence.getAttribute(SamplePolicySelectionForm.ATTR_SELECTED_POLICIES, null);
        selectedPolicies = new ArrayList();
        for (Iterator i = l.iterator(); i.hasNext();) {
            selectedPolicies.add(CoreServlet.getServlet().getPolicyDatabase().getPolicy(Integer.parseInt(i.next().toString()))
                            .getResourceName());
        }
        user = (User) sequence.getAttribute(SampleDetailsAction.ATTR_USER, null);
    }

    /**
     * @return Returns the name.
     */
    public String getResourceName() {
        return resourceName;
    }

    /**
     * @return Returns the selectedPolicies.
     */
    public List getSelectedPolicies() {
        return selectedPolicies;
    }

    /**
     * @return Returns the user.
     */
    public User getUser() {
        return user;
    }
}
