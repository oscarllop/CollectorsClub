<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/*">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <div class="v-menu">
      <nav class="nav-main mega-menu">
        <ul class="nav nav-pills nav-main" id="verticalMenu">
          <xsl:apply-templates select="node" />
        </ul>
      </nav>
    </div>
  </xsl:template>

  <xsl:template match="node">
    <li>
      <xsl:choose>
        <xsl:when test="@depth = 0">
          <xsl:attribute name="class">

            <xsl:text>dropdown</xsl:text>

            <xsl:if test="@selected = 1">
              <xsl:text> active</xsl:text>
            </xsl:if>

            <xsl:if test="@breadcrumb = 1">
              <xsl:text> active resp-active open</xsl:text>
            </xsl:if>

          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@depth > 0 and node">

          <xsl:attribute name="class">
            <xsl:text>dropdown-submenu</xsl:text>

            <xsl:if test="@selected = 1">
              <xsl:text> active</xsl:text>
            </xsl:if>

            <xsl:if test="@breadcrumb = 1">
              <xsl:text> active resp-active open</xsl:text>
            </xsl:if>

          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@depth > 0">

          <xsl:attribute name="class">
            <xsl:if test="@selected = 1">
              <xsl:text> active</xsl:text>
            </xsl:if>

          </xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="@enabled = 1">
          <a href="{@url}">

            <xsl:if test="@target ='_new' or @target = '_blank'">
              <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="node and @depth = 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown-toggle</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:value-of select="@text" />


          </a>
        </xsl:when>
        <xsl:otherwise>
          <a href="javascript:void(0)">
            <xsl:if test="node and @depth = 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown-toggle</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="node and @depth > 0">
              <xsl:attribute name="class">
                <xsl:text>dropdown-toggle</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="node">
              <xsl:attribute name="data-toggle">
                <xsl:text>dropdown</xsl:text>
              </xsl:attribute>
            </xsl:if>

            <xsl:value-of select="@text" />

          </a>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="node">
        <ul class="dropdown-menu">
          <xsl:apply-templates select="node" />
        </ul>
      </xsl:if>

    </li>
  </xsl:template>
</xsl:stylesheet>