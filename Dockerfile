FROM centos:7

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/16057/l_openvino_toolkit_p_2019.3.376.tgz

ARG INSTALL_DIR=/opt/intel/openvino

ARG TEMP_DIR=/tmp/openvino_installer

RUN yum update -y && yum install -y epel-release

#Install needed dependences
RUN yum install -y  \
        build-essential \
        cpio \
        curl \
        git \
	wget \
        lsb-release \
        pciutils \
        python3 \
        python3-devel \
        python3-pip \
        python3-setuptools \
        sudo \
	ffmpeg

RUN pip3 install numpy

#Install OpenVINO
RUN mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
    wget -c $DOWNLOAD_LINK && \
    tar xf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh --silent silent.cfg && \
    ./install_openvino_dependencies.sh -y && \
    rm -rf $TEMP_DIR

#Install Model Optimizer
RUN source $INSTALL_DIR/bin/setupvars.sh && \
    cd $INSTALL_DIR/deployment_tools/model_optimizer/install_prerequisites && \
    ./install_prerequisites.sh

RUN source $INSTALL_DIR/bin/setupvars.sh && \
    cd $INSTALL_DIR/install_dependencies && \
    ./install_NCS_udev_rules.sh && \
    ./install_NEO_OCL_driver.sh

RUN source $INSTALL_DIR/bin/setupvars.sh && \
    echo "source $INSTALL_DIR/bin/setupvars.sh" >> /root/.bashrc

CMD ["/bin/bash"]
