
package com.sf.integration.expressservice.service;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.4-b01
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "CommonServiceService", targetNamespace = "http://service.expressservice.integration.sf.com/", wsdlLocation = "http://bsp-test.sf-express.com:9090/bsp-ois/ws/expressService?wsdl")
public class CommonServiceService
    extends Service
{

    private final static URL COMMONSERVICESERVICE_WSDL_LOCATION;
    private final static WebServiceException COMMONSERVICESERVICE_EXCEPTION;
    private final static QName COMMONSERVICESERVICE_QNAME = new QName("http://service.expressservice.integration.sf.com/", "CommonServiceService");
    private final static String SANDBOX = "http://bsp-test.sf-express.com:9090/bsp-ois/ws/expressService?wsdl";
    private final static String PRODUCT = "http://bsp-oisp.sf-express.com/bsp-oisp/ws/expressService?wsdl";

    static {
        URL url = null;
        WebServiceException e = null;
        try {
            url = new URL(SANDBOX);
        } catch (MalformedURLException ex) {
            e = new WebServiceException(ex);
        }
        COMMONSERVICESERVICE_WSDL_LOCATION = url;
        COMMONSERVICESERVICE_EXCEPTION = e;
    }

    public CommonServiceService() {
        super(__getWsdlLocation(), COMMONSERVICESERVICE_QNAME);
    }

    public CommonServiceService(WebServiceFeature... features) {
        super(__getWsdlLocation(), COMMONSERVICESERVICE_QNAME, features);
    }

    public CommonServiceService(URL wsdlLocation) {
        super(wsdlLocation, COMMONSERVICESERVICE_QNAME);
    }

    public CommonServiceService(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, COMMONSERVICESERVICE_QNAME, features);
    }

    public CommonServiceService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public CommonServiceService(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns IService
     */
    @WebEndpoint(name = "CommonServicePort")
    public IService getCommonServicePort() {
        return super.getPort(new QName("http://service.expressservice.integration.sf.com/", "CommonServicePort"), IService.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns IService
     */
    @WebEndpoint(name = "CommonServicePort")
    public IService getCommonServicePort(WebServiceFeature... features) {
        return super.getPort(new QName("http://service.expressservice.integration.sf.com/", "CommonServicePort"), IService.class, features);
    }

    private static URL __getWsdlLocation() {
        if (COMMONSERVICESERVICE_EXCEPTION!= null) {
            throw COMMONSERVICESERVICE_EXCEPTION;
        }
        return COMMONSERVICESERVICE_WSDL_LOCATION;
    }

}
