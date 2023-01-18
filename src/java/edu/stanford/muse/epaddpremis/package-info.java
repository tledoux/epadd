

@XmlSchema(
        namespace = "http://www.loc.gov/premis/v3",
        elementFormDefault = XmlNsForm.QUALIFIED,
        xmlns = {
                @XmlNs(prefix = "premis", namespaceURI = "http://www.loc.gov/premis/v3"),
                @XmlNs(prefix = "xsi", namespaceURI = "http://www.w3.org/2001/XMLSchema-instance"),
                @XmlNs(prefix = "xlink", namespaceURI = "http://www.w3.org/1999/xlink"),
        })

package edu.stanford.muse.epaddpremis;

import jakarta.xml.bind.annotation.XmlNs;
import jakarta.xml.bind.annotation.XmlNsForm;
import jakarta.xml.bind.annotation.XmlSchema;