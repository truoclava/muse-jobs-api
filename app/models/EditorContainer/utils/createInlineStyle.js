import React, { Component } from 'react';
import { RichUtils } from 'draft-js';
import { Button } from 'semantic-ui-react'

export default ({ style, children }) => (
  class InlineStyleButton extends Component {
    constructor(props) {
      super(props)

      this.toggleStyle = this.toggleStyle.bind(this)
      this.preventBubblingUp = this.preventBubblingUp.bind(this)
      this.styleIsActive = this.styleIsActive.bind(this)
    }

    toggleStyle(event) {
      event.preventDefault()

      this.props.setEditorState(
        RichUtils.toggleInlineStyle(
          this.props.getEditorState(),
          style
        )
      );
    }

    preventBubblingUp(event) { event.preventDefault() }

    styleIsActive() {
      return this.props.getEditorState && this.props.getEditorState().getCurrentInlineStyle().has(style)
    }

    render() {
      return (
        <Button
          icon
          active={this.styleIsActive()}
          onClick={this.toggleStyle}
          children={children}
        />
      );
    }
  }
);
