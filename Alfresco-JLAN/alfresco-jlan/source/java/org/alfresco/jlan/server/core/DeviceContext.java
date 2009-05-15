/*
 * Copyright (C) 2006-2008 Alfresco Software Limited.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

 * As a special exception to the terms and conditions of version 2.0 of 
 * the GPL, you may redistribute this Program in connection with Free/Libre 
 * and Open Source Software ("FLOSS") applications as described in Alfresco's 
 * FLOSS exception.  You should have recieved a copy of the text describing 
 * the FLOSS exception, and it is also available here: 
 * http://www.alfresco.com/legal/licensing"
 */

package org.alfresco.jlan.server.core;

import org.alfresco.config.ConfigElement;

/**
 * <p>The device context is passed to the methods of a device interface. Each shared device has a
 * device interface and a device context associated with it. The device context allows a single
 * device interface to be used for multiple shared devices.
 *
 * @author gkspencer
 */
public class DeviceContext {

  //	Device name that the interface is associated with

  private String m_devName;

	//	Configuration parameters
	
	private ConfigElement m_params;

	//	Flag to indicate if the device is available. Unavailable devices will not be listed by the various
	//	protocol servers.
	
	private boolean m_available = true;
	
  // Shared device name
  
  private String m_shareName;
  
  /**
   * DeviceContext constructor.
   */
  public DeviceContext() {
    super();
  }
  
  /**
   * Class constructor
   * 
   * @param devName String
   */
  public DeviceContext(String devName) {
    m_devName = devName;
  }

  /**
   * Class constructor
   * 
   * @param devName String
   * @param shareName String
   */
  public DeviceContext(String devName, String shareName) {
    m_devName = devName;
    m_shareName = shareName;
  }
  
  /**
   * Return the device name.
   *
   * @return java.lang.String
   */
  public final String getDeviceName() {
    return m_devName;
  }

  /**
   * Return the shared device name
   * 
   * @return String
   */
  public final String getShareName() {
    return m_shareName;
  }
  
	/**
	 * Determine if the device context has any configuration parameters
	 * 
	 * @return boolean
	 */
	public final boolean hasConfigurationParameters() {
		return m_params != null ? true : false;
	}
	
	/**
	 * Determine if the filesystem is available
	 * 
	 * @return boolean
	 */
	public final boolean isAvailable() {
	  return m_available;
	}
	
	/**
	 * Return the configuration parameters
	 * 
	 * @return ConfigElement
	 */  
	public final ConfigElement getConfigurationParameters() {
		return m_params;
	}

	/**
	 * Set the filesystem as available, or not
	 * 
	 * @param avail boolean
	 */
	public final void setAvailable(boolean avail) {
	  m_available = avail;
	}
	
  /**
   * Set the device name.
   *
   * @param name java.lang.String
   */
  public final void setDeviceName(String name) {
    m_devName = name;
  }
  
  /**
   * Set the shared device name
   * 
   * @param shareName String
   */
  public final void setShareName( String shareName) {
    m_shareName = shareName;
  }
  
  /**
   * Set the configuration parameters
   *
   * @param params ConfigElement
   */
  public final void setConfigurationParameters(ConfigElement params) {
  	m_params = params;
  }

  /**
   * Close the device context, free any resources allocated by the context
   */
  public void CloseContext() {
  }
  
	/**
	 * Return the context as a string
	 * 
	 * @return String
	 */
	public String toString() {
		StringBuffer str = new StringBuffer();
		
		str.append("[");
		str.append(getDeviceName());
		str.append("]");
		
		return str.toString();
	}
}