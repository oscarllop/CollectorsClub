<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/*">
    <xsl:apply-templates select="root" />
  </xsl:template>
  <xsl:template match="root">
    <nav class="nav-main mega-menu">
      <ul class="nav nav-pills nav-main" id="mainMenu">
        <xsl:apply-templates select="node" />
      </ul>
    </nav>
  </xsl:template>
  <xsl:template match="node">
    <li>
      <xsl:if test="node">
        <xsl:if test="@depth = 0">
          <xsl:attribute name="data-col">
            <xsl:value-of select="@commandargument" />
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@depth = 0 and @commandargument &gt; 1 or @depth = 0 and @commandargument = 0">
            <xsl:if test="@title = 'True'">
              <xsl:if test="@breadcrumb = 1">
                <xsl:attribute name="class">
                  <xsl:text>dropdown mega-menu-item mega-menu-fullwidth active</xsl:text>

                  <xsl:if test="@id = 1">
                    <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 2">
                    <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 3">
                    <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 4">
                    <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 5">
                    <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
                  </xsl:if>

                </xsl:attribute>
              </xsl:if>
              <xsl:if test="@breadcrumb = 0">
                <xsl:attribute name="class">
                  <xsl:text>dropdown mega-menu-item mega-menu-fullwidth</xsl:text>

                  <xsl:if test="@id = 1">
                    <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 2">
                    <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 3">
                    <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 4">
                    <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 5">
                    <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
                  </xsl:if>

                </xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:if test="@title = 'False'">
              <xsl:if test="@breadcrumb = 1">
                <xsl:attribute name="class">
                  <xsl:text>dropdown mega-menu-item active</xsl:text>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="@breadcrumb = 0">
                <xsl:attribute name="class">
                  <xsl:text>dropdown mega-menu-item</xsl:text>

                  <xsl:if test="@id = 1">
                    <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 2">
                    <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 3">
                    <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 4">
                    <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
                  </xsl:if>
                  <xsl:if test="@id = 5">
                    <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
                  </xsl:if>

                </xsl:attribute>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:when test="@depth = 0">
            <xsl:if test="@breadcrumb = 1">
              <xsl:attribute name="class">
                <xsl:text>dropdown active</xsl:text>

                <xsl:if test="@id = 1">
                  <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 2">
                  <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 3">
                  <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 4">
                  <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 5">
                  <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
                </xsl:if>

              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@breadcrumb = 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown</xsl:text>

                <xsl:if test="@id = 1">
                  <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 2">
                  <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 3">
                  <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 4">
                  <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
                </xsl:if>
                <xsl:if test="@id = 5">
                  <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
                </xsl:if>

              </xsl:attribute>
            </xsl:if>
          </xsl:when>
          <xsl:when test="@depth &gt; 0">
            <xsl:attribute name="class">
              <xsl:text>dropdown-submenu</xsl:text>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="not(node) and @depth = 0 and @selected = 1">
        <xsl:attribute name="class">
          <xsl:text>active</xsl:text>

          <xsl:if test="@id = 1">
            <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 2">
            <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 3">
            <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 4">
            <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 5">
            <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
          </xsl:if>

        </xsl:attribute>
      </xsl:if>
      <xsl:if test="not(node) and @depth = 0 and @selected = 0">
        <xsl:attribute name="class">

          <xsl:if test="@id = 1">
            <xsl:text> dropdown-full-color dropdown-primary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 2">
            <xsl:text> dropdown-full-color dropdown-secondary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 3">
            <xsl:text> dropdown-full-color dropdown-tertiary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 4">
            <xsl:text> dropdown-full-color dropdown-quaternary</xsl:text>
          </xsl:if>
          <xsl:if test="@id = 5">
            <xsl:text> dropdown-full-color dropdown-dark</xsl:text>
          </xsl:if>

        </xsl:attribute>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="@enabled = 1">
          <a href="{@url}">
            
            <xsl:if test="@target = '_new' or @target = '_blank'">
              <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="node and @depth = 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown-toggle</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="@icon">
              <img src="{@icon}"/> &#160;
            </xsl:if>
            
            <xsl:value-of select="@text" />

            <xsl:if test="@largeimage">
              &#160; <img src="{@largeimage}"/>
            </xsl:if>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <a href="javascript:void(0)">
            <xsl:if test="node and @depth = 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown-toggle</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="@icon">
              <img src="{@icon}"/> &#160;
            </xsl:if>
            
            <xsl:value-of select="@text" />

            <xsl:if test="@largeimage">
              &#160; <img src="{@largeimage}"/>
            </xsl:if>
          </a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="node">
        <ul class="dropdown-menu">
          <xsl:apply-templates select="node" />
        </ul>
      </xsl:if>

      <xsl:if test="keywords and @depth = 0">
        <div class="lft-cont" style="display:none;">
          <xsl:value-of select="keywords" />
        </div>
      </xsl:if>

      <xsl:if test="description and @depth = 0">
        <div class="rgt-cont" style="display:none;">
          <xsl:value-of select="description" />
        </div>
      </xsl:if>
    </li>
  </xsl:template>
</xsl:stylesheet>
