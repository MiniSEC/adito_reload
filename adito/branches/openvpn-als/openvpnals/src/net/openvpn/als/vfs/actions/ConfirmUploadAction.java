package net.openvpn.als.vfs.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.openvpn.als.core.CoreUtil;
import net.openvpn.als.core.actions.AbstractPopupAuthenticatedDispatchAction;
import net.openvpn.als.security.Constants;
import net.openvpn.als.security.SessionInfo;
import net.openvpn.als.vfs.UploadDetails;
import net.openvpn.als.vfs.forms.UploadForm;

public class ConfirmUploadAction extends AbstractPopupAuthenticatedDispatchAction {

    static Log log = LogFactory.getLog(UploadAction.class);
        
    public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            if (log.isDebugEnabled())
                log.debug("Execute file upload.");
            
            String confirm = request.getParameter("confirm");
            ActionForm uploadForm = (UploadForm)request.getSession().getAttribute("uploadForm");
            form = (UploadForm)uploadForm;
            int uploadId = ((UploadForm)uploadForm).getUploadId();
            UploadDetails upload = CoreUtil.getUpload(request.getSession(), uploadId);
            request.setAttribute(Constants.REQ_ATTR_UPLOAD_DETAILS, uploadId);
            UploadAction action = new UploadAction();
            request.getSession().removeAttribute("uploadForm");
            if("yes".equals(confirm)) {
                return action.confirmUpload(mapping, uploadForm, request, response);
            } else {
                return new ActionForward(upload.getUploadedForward().getPath());
            }
        } catch (Exception e) {
            log.error("Confirm Upload error: " + e);
            throw e;
        }
    }

    public int getNavigationContext(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        return SessionInfo.MANAGEMENT_CONSOLE_CONTEXT | SessionInfo.USER_CONSOLE_CONTEXT;
    }

}
