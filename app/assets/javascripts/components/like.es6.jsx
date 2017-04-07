class Like extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      liked: this.props.liked,
      likesCount: this.props.likesCount,
      isLoggedIn: this.props.isLoggedIn || false
    }
  }

  like() {
    $.post(this.props.url)
    this.setState({ liked: true, likesCount: this.state.likesCount+1 })
  }

  dislike() {
    $.ajax(this.props.url, { type: 'DELETE' })
    this.setState({ liked: false, likesCount: this.state.likesCount-1 })
  }

  handleClick() {
    if (this.state.isLoggedIn) {
      this.state.liked ? this.dislike() : this.like();
    } else {
      window.location = GHMData.paths.signin;
    }
  }

  render() {
    return (
      <a className="like" href="javascript:;" onClick={ this.handleClick.bind(this) }>
        <i className={ this.state.liked ? 'fa fa-heart' : 'fa fa-heart-o' }></i>
        &nbsp;
        { this.state.likesCount }
      </a>
    );
  }

}
