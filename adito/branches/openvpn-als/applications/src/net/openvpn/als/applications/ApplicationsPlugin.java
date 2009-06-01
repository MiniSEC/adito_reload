
				/*
 *  OpenVPN-ALS
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
			
package net.openvpn.als.applications;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Element;

import net.openvpn.als.agent.DefaultAgentManager;
import net.openvpn.als.applications.types.ExecutableType;
import net.openvpn.als.applications.types.HtmlType;
import net.openvpn.als.applications.types.JavaType;
import net.openvpn.als.applications.types.JavasType;
import net.openvpn.als.applications.types.ServerType;
import net.openvpn.als.core.CoreEvent;
import net.openvpn.als.core.CoreEventConstants;
import net.openvpn.als.core.CoreListener;
import net.openvpn.als.core.CoreMenuTree;
import net.openvpn.als.core.CoreServlet;
import net.openvpn.als.core.CoreUtil;
import net.openvpn.als.core.MenuItem;
import net.openvpn.als.core.PageTaskMenuTree;
import net.openvpn.als.extensions.ExtensionBundle;
import net.openvpn.als.extensions.ExtensionDescriptor;
import net.openvpn.als.extensions.ExtensionException;
import net.openvpn.als.extensions.ExtensionTypeManager;
import net.openvpn.als.extensions.types.DefaultPlugin;
import net.openvpn.als.extensions.types.PluginDefinition;
import net.openvpn.als.navigation.MenuTree;
import net.openvpn.als.navigation.NavigationManager;
import net.openvpn.als.policyframework.Permission;
import net.openvpn.als.policyframework.PolicyConstants;
import net.openvpn.als.policyframework.PolicyDatabase;
import net.openvpn.als.policyframework.PolicyDatabaseFactory;
import net.openvpn.als.policyframework.PolicyUtil;
import net.openvpn.als.policyframework.ResourceType;
import net.openvpn.als.policyframework.itemactions.AddToFavoritesAction;
import net.openvpn.als.policyframework.itemactions.CloneResourceAction;
import net.openvpn.als.policyframework.itemactions.EditResourceAction;
import net.openvpn.als.policyframework.itemactions.RemoveFromFavoritesAction;
import net.openvpn.als.policyframework.itemactions.RemoveResourceAction;
import net.openvpn.als.security.SessionInfo;
import net.openvpn.als.table.TableItemActionMenuTree;

/**
 * Plugin implementation that provides the <i>Applications</i> feature.
 * <p>
 * By itself, this extension does not do much, the <i>Application Extension</i>
 * for the application to be used must be downloaded from the 3SP Extension
 * Store.
 * <p>
 * Once an Application Extension is installed, <i>Application Shortcuts</i> may
 * then be created. Application Shortcuts are used to configure and launch
 * instances of any installed and supported Application.
 */
public class ApplicationsPlugin extends DefaultPlugin implements CoreListener {

	/**
	 * Application shortcut resource type ID
	 */
	public final static int APPLICATION_SHORTCUT_RESOURCE_TYPE_ID = 3;

	/**
	 * Application shortcut resource type
	 */
	public static final ResourceType APPLICATION_SHORTCUT_RESOURCE_TYPE = new ApplicationShortcutResourceType();

	/**
	 * Extension bundle ID
	 */
	public static final String BUNDLE_ID = "applications";

	final static Log log = LogFactory.getLog(ApplicationsPlugin.class);

	/**
	 * Message resources key (resource bundle id)
	 */
	public static final String MESSAGE_RESOURCES_KEY = "applications";

	/**
	 * Constructor.
	 */
	public ApplicationsPlugin() {
		super("/WEB-INF/applications-tiles-defs.xml", true);
	}

	/* (non-Javadoc)
     * @see net.openvpn.als.extensions.types.DefaultPlugin#startPlugin(net.openvpn.als.extensions.types.PluginDefinition, net.openvpn.als.extensions.ExtensionDescriptor, org.jdom.Element)
     */
    public void startPlugin(PluginDefinition definition, ExtensionDescriptor descriptor, Element element) throws ExtensionException {
        super.startPlugin(definition, descriptor, element);
        try {
            initExtensionTypes();
        } catch (Exception e) {
            throw new ExtensionException(ExtensionException.INTERNAL_ERROR, e);
        }
    }

    /*
	 * (non-Javadoc)
	 * 
	 * @see net.openvpn.als.plugin.DefaultPlugin#startPlugin()
	 */
	public void activatePlugin() throws ExtensionException {
		super.activatePlugin();
		try {
			initDatabase();
			initAgentService();
			initPolicyFramework();
			initTableItemActions();
			initMainMenu();
			initPageTasks();
            CoreUtil.updateEventsTable(ApplicationsPlugin.MESSAGE_RESOURCES_KEY, ApplicationShortcutEventConstants.class);
			CoreServlet.getServlet().addCoreListener(this);
		} catch (Exception e) {
            e.printStackTrace();
			throw new ExtensionException(ExtensionException.INTERNAL_ERROR, e);
		}
	}

	void initDatabase() throws Exception {
		ApplicationShortcutDatabaseFactory.getInstance().open(CoreServlet.getServlet(), this.getPluginDefinition());
	}

	void initAgentService() throws Exception {
		DefaultAgentManager.getInstance().registerService(ApplicationService.class);
	}

	void initExtensionTypes() throws Exception {
		ExtensionTypeManager.getInstance().registerExtensionType("server", ServerType.class);
		ExtensionTypeManager.getInstance().registerExtensionType("javas", JavasType.class);
		ExtensionTypeManager.getInstance().registerExtensionType("java", JavaType.class);
		ExtensionTypeManager.getInstance().registerExtensionType("executable", ExecutableType.class);
		ExtensionTypeManager.getInstance().registerExtensionType("html", HtmlType.class);
	}

	void initPolicyFramework() throws Exception {

		PolicyDatabase pdb = PolicyDatabaseFactory.getInstance();

		// Application Shortcut
		pdb.registerResourceType(APPLICATION_SHORTCUT_RESOURCE_TYPE);
		APPLICATION_SHORTCUT_RESOURCE_TYPE.addPermission(PolicyConstants.PERM_CREATE_EDIT_AND_ASSIGN);
		APPLICATION_SHORTCUT_RESOURCE_TYPE.addPermission(PolicyConstants.PERM_EDIT_AND_ASSIGN);
		APPLICATION_SHORTCUT_RESOURCE_TYPE.addPermission(PolicyConstants.PERM_ASSIGN);
		APPLICATION_SHORTCUT_RESOURCE_TYPE.addPermission(PolicyConstants.PERM_DELETE);
		APPLICATION_SHORTCUT_RESOURCE_TYPE.addPermission(PolicyConstants.PERM_PERSONAL_CREATE_EDIT_AND_DELETE);
	}

	void initTableItemActions() throws Exception {
		MenuTree tree = NavigationManager.getMenuTree(TableItemActionMenuTree.MENU_TABLE_ITEM_ACTION_MENU_TREE);

		// Application shortcuts
		tree.addMenuItem(null, new MenuItem("applicationShortcuts",
						ApplicationsPlugin.MESSAGE_RESOURCES_KEY,
						null,
						100,
						false,
						SessionInfo.ALL_CONTEXTS));
		tree.addMenuItem("applicationShortcuts", new AddToFavoritesAction(ApplicationsPlugin.MESSAGE_RESOURCES_KEY));
		tree.addMenuItem("applicationShortcuts", new RemoveFromFavoritesAction(ApplicationsPlugin.MESSAGE_RESOURCES_KEY));
		tree.addMenuItem("applicationShortcuts", new RemoveResourceAction(SessionInfo.ALL_CONTEXTS,
						ApplicationsPlugin.MESSAGE_RESOURCES_KEY));
		tree.addMenuItem("applicationShortcuts", new EditResourceAction(SessionInfo.ALL_CONTEXTS,
						ApplicationsPlugin.MESSAGE_RESOURCES_KEY));
		tree.addMenuItem("applicationShortcuts", new CloneResourceAction(SessionInfo.MANAGEMENT_CONSOLE_CONTEXT,
			ApplicationsPlugin.MESSAGE_RESOURCES_KEY));
	}

	void initMainMenu() throws Exception {
		MenuTree tree = NavigationManager.getMenuTree(CoreMenuTree.MENU_ITEM_MENU_TREE);

		tree.addMenuItem("resources", new MenuItem("userApplicationShortcuts",
						MESSAGE_RESOURCES_KEY,
						"/showUserApplicationShortcuts.do",
						300,
						true,
						null,
						SessionInfo.USER_CONSOLE_CONTEXT,
                        APPLICATION_SHORTCUT_RESOURCE_TYPE,
                        new Permission[] { PolicyConstants.PERM_PERSONAL_CREATE_EDIT_AND_DELETE },
                        APPLICATION_SHORTCUT_RESOURCE_TYPE));

		tree.addMenuItem("globalResources", new MenuItem("applicationShortcuts",
						MESSAGE_RESOURCES_KEY,
						"/showApplicationShortcuts.do",
						300,
						true,
						null,
						SessionInfo.MANAGEMENT_CONSOLE_CONTEXT,
						APPLICATION_SHORTCUT_RESOURCE_TYPE,
						new Permission[] { PolicyConstants.PERM_CREATE_EDIT_AND_ASSIGN,
							PolicyConstants.PERM_EDIT_AND_ASSIGN,
							PolicyConstants.PERM_DELETE,
							PolicyConstants.PERM_ASSIGN }) {
			public boolean isAvailable(int checkNavigationContext, SessionInfo info, HttpServletRequest request) {
				boolean available = super.isAvailable(checkNavigationContext, info, request);
				if (available) {
					try {

						PolicyUtil.checkPermissions(APPLICATION_SHORTCUT_RESOURCE_TYPE,
							new Permission[] { PolicyConstants.PERM_CREATE_EDIT_AND_ASSIGN,
								PolicyConstants.PERM_EDIT_AND_ASSIGN,
								PolicyConstants.PERM_DELETE,
								PolicyConstants.PERM_ASSIGN },
							request);
						available = true;
					} catch (Exception e1) {
						available = false;
					}
				}
				return available;
			}
		});
	}

	void initPageTasks() throws Exception {
		MenuTree tree = NavigationManager.getMenuTree(PageTaskMenuTree.PAGE_TASK_MENU_TREE);

		tree.addMenuItem(null, new MenuItem("showApplicationShortcuts",
						null,
						null,
						100,
						false,
						SessionInfo.MANAGEMENT_CONSOLE_CONTEXT));
		tree.addMenuItem("showApplicationShortcuts", new MenuItem("createApplicationShortcut",
						ApplicationsPlugin.MESSAGE_RESOURCES_KEY,
						"/applicationShortcutApplication.do",
						100,
						true,
						"_self",
						SessionInfo.MANAGEMENT_CONSOLE_CONTEXT,
						APPLICATION_SHORTCUT_RESOURCE_TYPE,
						new Permission[] { PolicyConstants.PERM_CREATE_EDIT_AND_ASSIGN }));
        
        // userApplicationShorctuts
        tree.addMenuItem(null, new MenuItem("showUserApplicationShortcuts", null, null, 100, false, SessionInfo.USER_CONSOLE_CONTEXT));
        tree.addMenuItem("showUserApplicationShortcuts", new MenuItem("createPersonalApplicationShortcut",
                        ApplicationsPlugin.MESSAGE_RESOURCES_KEY,
                        "/applicationShortcutApplication.do",
                        100,
                        true,
                        "_self",
                        SessionInfo.USER_CONSOLE_CONTEXT,
                        APPLICATION_SHORTCUT_RESOURCE_TYPE,
                        new Permission[] { PolicyConstants.PERM_PERSONAL_CREATE_EDIT_AND_DELETE }));
	}

	public void coreEvent(CoreEvent evt) {
		if (evt.getId() == CoreEventConstants.REMOVING_EXTENSION) {
			ExtensionBundle bundle = (ExtensionBundle) evt.getParameter();
			for (Iterator itr = bundle.iterator(); itr.hasNext();) {
				ExtensionDescriptor app = (ExtensionDescriptor) itr.next();
				try {
					ApplicationShortcutDatabaseFactory.getInstance().removeApplicationShortcuts(app.getId());
				} catch (Exception e) {
					log.error("Failed to remove application shortcuts for removed extension " + bundle.getId());
				}
			}
		}

	}
    
    public void stopPlugin() throws ExtensionException {
        super.stopPlugin();
        try {
            removeExtensionTypes();
            stopDatabase();
            removeAgentService();
            removePolicyFramework();
            removeTableItemActions();
            removeMainMenu();
            removePageTasks();
            CoreServlet.getServlet().removeCoreListener(this);
        } catch (Exception e) {
            throw new ExtensionException(ExtensionException.INTERNAL_ERROR, e, "Failed to start.");
        }
    }

    private void removePageTasks() {
        MenuTree tree = NavigationManager.getMenuTree(PageTaskMenuTree.PAGE_TASK_MENU_TREE);
        tree.removeMenuItem("showApplicationShortcuts", "createApplicationShortcut");
    }

    private void removeMainMenu() {
        MenuTree tree = NavigationManager.getMenuTree(CoreMenuTree.MENU_ITEM_MENU_TREE);
        tree.removeMenuItem("resources", "userApplicationShortcuts");
        tree.removeMenuItem("globalResources", "applicationShortcuts");
    }

    private void removeTableItemActions() {
        MenuTree tree = NavigationManager.getMenuTree(TableItemActionMenuTree.MENU_TABLE_ITEM_ACTION_MENU_TREE);
        tree.removeMenuItem("applicationShortcuts", AddToFavoritesAction.TABLE_ITEM_ACTION_ID);
        tree.removeMenuItem("applicationShortcuts", RemoveFromFavoritesAction.TABLE_ITEM_ACTION_ID);
        tree.removeMenuItem("applicationShortcuts", RemoveResourceAction.TABLE_ITEM_ACTION_ID);
        tree.removeMenuItem("applicationShortcuts", EditResourceAction.TABLE_ITEM_ACTION_ID);
    }

    private void removePolicyFramework() throws Exception {

        PolicyDatabase pdb = PolicyDatabaseFactory.getInstance();
        pdb.deregisterResourceType(APPLICATION_SHORTCUT_RESOURCE_TYPE);
    }

    private void removeAgentService() {
         DefaultAgentManager.getInstance().unregisterService(ApplicationService.class);
    }

    private void stopDatabase() throws Exception {
        ApplicationShortcutDatabaseFactory.getInstance().close();
    }

    private void removeExtensionTypes() {
        ExtensionTypeManager.getInstance().unregisterExtensionType("server");
        ExtensionTypeManager.getInstance().unregisterExtensionType("javas");
        ExtensionTypeManager.getInstance().unregisterExtensionType("java");
        ExtensionTypeManager.getInstance().unregisterExtensionType("executable");
        ExtensionTypeManager.getInstance().unregisterExtensionType("html");
    }

}
